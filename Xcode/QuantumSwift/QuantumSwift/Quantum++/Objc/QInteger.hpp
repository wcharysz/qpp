//
//  QInteger.hpp
//  QuantumSwift
//
//  Created by Wojciech Charysz on 28.05.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

#ifndef QInteger_hpp
#define QInteger_hpp

#include <stdio.h>
#include <qpp.h>

#endif /* QInteger_hpp */

namespace qpp {
    class QInteger {
        
    private:
        bigint number;
        ket psiFromInteger();
        
    public:
        QInteger(bigint integer);
        ket psi;
        bigint integerFromPsi();
    };
}


