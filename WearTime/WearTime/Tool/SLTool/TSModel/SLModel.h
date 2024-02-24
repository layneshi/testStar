//
//  TSModel.h
//  TSModel <https://github.com/ibireme/SLModel>
//
//  Created by ibireme on 15/5/10.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <Foundation/Foundation.h>

#if __has_include(<SLModel/SLModel.h>)
FOUNDATION_EXPORT double SLModelVersionNumber;
FOUNDATION_EXPORT const unsigned char SLModelVersionString[];
#import <SLModel/NSObject+SLModel.h>
#import <SLModel/SLClassInfo.h>
#else
#import "NSObject+SLModel.h"
#import "SLClassInfo.h"
#endif
