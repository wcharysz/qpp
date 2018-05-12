//
//  ObjCqpp.m
//  QuantumSwift
//
//  Created by Wojciech Charysz on 10.05.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

#import "ObjCqpp.h"
#import <qpp.h>

@implementation ObjCqpp

- (void)minimal {
    
    qpp::ket zero = qpp::st.z0;
    NSLog(@"Hello Quantum++!\nThis is the |0> state:\n");
}

- (nullable NSArray<NSNumber *> *)shorFor:(NSInteger)number {
    
    // First check the most trivial case, if the provided number is even
    if (number % 2 == 0) {
        NSLog(@"An even number has been passed; 2 is the factor.");
        return @[@(number / 2), @2];
    }
    
    // Next try to guess a number co-prime to `number`
    // Get a random integer in the interval [1,number-1]
    NSUInteger coprimeCandidate = arc4random_uniform(uint32_t(number)) + 1;
    
    // Check if the random integer indeed co-prime using Greatest common divisor
    BOOL isCoprime = [self gcdFor:coprimeCandidate andNumber:number] == 1;
    
    // If true use Quantum algorithm for Period finding.
    if (isCoprime) {
        NSLog(@"Estimating period of %ld", (long)coprimeCandidate);
        
        // Call Quantum Period finding algorithm for
        // `coprimeCandidate` mod `number`.
        // Here we have a choice which Phase Estimation algorithm to use.
        //let period = EstimatePeriod(coprimeCandidate, number, useRobustPhaseEstimation);
        NSUInteger period = [self estimatePeriod:coprimeCandidate andNumber:number];
    }
    
    
    
    
    return nil;
    /*
     // First check the most trivial case, if the provided number is even
     if (  number % 2 == 0 ) {
     Message("An even number has been passed; 2 is the factor.");
     return (number / 2, 2);
     }
     
     // Next try to guess a number co-prime to `number`
     // Get a random integer in the interval [1,number-1]
     let coprimeCandidate = RandomInt(number - 2) + 1;
     
     // Check if the random integer indeed co-prime using
     // Microsoft.Quantum.Canon.IsCoprime.
     // If true use Quantum algorithm for Period finding.
     if( IsCoprime(coprimeCandidate, number) ) {
     
     // Print a message using Microsoft.Quantum.Primitive.Message
     // indicating that we are doing something quantum.
     Message($"Estimating period of {coprimeCandidate}");
     
     // Call Quantum Period finding algorithm for
     // `coprimeCandidate` mod `number`.
     // Here we have a choice which Phase Estimation algorithm to use.
     let period = EstimatePeriod(coprimeCandidate, number, useRobustPhaseEstimation);
     
     // Period finding reduces to factoring only if period is even
     if( period % 2 == 0 ) {
     
     // Compute `coprimeCandidate` ^ `period/2` mod `number`
     // using Microsoft.Quantum.ExpMod.
     let halfPower = ExpMod(coprimeCandidate,period/2,number);
     
     // If we are unlucky, halfPower is just -1 mod N,
     // This is a trivial case not useful for factoring
     if( halfPower != number - 1 ) {
     
     // When the halfPower is not -1 mod N
     // halfPower-1 or halfPower+1 share non-trivial divisor with `number`.
     // We find a divisor Microsoft.Quantum.Canon.GCD.
     let factor = MaxI(GCD(halfPower-1, number), GCD(halfPower+1, number));
     
     // Return computed non-trivial factors.
     return (factor,number/factor);
     }
     else {
     
     // Report the failure of hitting a trivial case.
     // We have to start over again.
     fail "Residue xᵃ = -1 (mod N) where a is a period.";
     }
     }
     else {
     // When period is odd we have to pick another number to estimate
     // period of and start over.
     fail "Period is odd.";
     }
     
     // This line will never be reached, however Q# compiler requires it here
     // as otherwise this looks like somebody forgot a return statement.
     // C# is more advance and will show a warning:
     // Warning    CS0162    Unreachable code detected ShorWithCanon.qs:71
     return (0,0);
     }
     else { // In this case we guessed a divisor by accident
     // Find a divisor using Microsoft.Quantum.Canon.GCD
     let gcd = GCD(number,coprimeCandidate);
     
     // And do not forget to tell the user that we were lucky and didn't do anything
     // quantum using Microsoft.Quantum.Primitive.Message
     Message($"We have guessed a divisor of {number} to be {gcd} by accident.");
     
     // Return the factorization
     return ( gcd, number / gcd );
     }
     }
     */
}

- (NSUInteger)qubitsRequiredFor:(NSUInteger)number {
    number >>= 1;
    NSUInteger i;
    
    for(i=1; number > 0 ;i++) {
        number >>= 1;
    }
    
    return i;
}

- (NSUInteger)gcdFor:(NSUInteger)u andNumber:(NSUInteger)v {
    
    if (u == 0) {
        return v;
    }
    
    if (v == 0) {
        return u;
    }
    
    NSInteger a = ABS(u);
    NSInteger b = ABS(v);
    
    if (b > a) {
        std::swap(a,b);
    }
    
    while (b > 0) {
        std::tie(a, b) = std::make_tuple(b, a % b);
    }
    
    return a;
}

- (void)groverFor:(NSUInteger)number {
    using namespace qpp;
    
    idx numberOfQubits = [self qubitsRequiredFor:number];
    std::vector<qpp::idx> dims(numberOfQubits, 2);
    
    // number of elements in the database
    idx N = std::round(std::pow(2, numberOfQubits));
    
    // mark an element randomly
    idx marked = randidx(0, N - 1);
    
    // computational |0>^\otimes n
    ket psi = mket(n2multiidx(0, dims));
    
    // apply H^\otimes n, no aliasing
    psi = (kronpow(gt.H, numberOfQubits) * psi).eval();
    
    // Diffusion operator
    cmat G = 2 * prj(psi) - gt.Id(N);
    
    // number of queries
    idx nqueries = std::ceil(M_PI / 4 * std::sqrt(N));
    
    for (idx i = 0; i < nqueries; ++i) {
        psi(marked) = -psi(marked); // apply the oracle first, no aliasing
        psi = (G * psi).eval();     // then the diffusion operator, no aliasing
    }
    
    // we now measure the state in the computational basis
    auto measured = measure(psi, gt.Id(N));
    
    NSLog(@"Probability of the marked state:  %f", std::get<1>(measured)[marked]);
    //NSLog(@"Probability of all results: %s", disp(std::get<1>(measured), ", "));
    
    //sample
    idx result = std::get<0>(measured);
    
    if (result == marked) {
        NSLog(@"Hooray, we obtained the correct result");
        NSLog(@"Result: %lu", result);
        NSLog(@"Marked: %lu", marked);
    }
}

- (NSUInteger)estimatePeriod:(NSUInteger)candidate andNumber:(NSUInteger)number {
    //Phase Estimation algorithm
    using namespace qpp;
    
    return 0;
}

@end
