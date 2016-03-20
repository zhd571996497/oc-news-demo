//
//  AFN.h
//  休闲影糖2
//
//  Created by dllo on 15/4/13.
//  Copyright (c) 2015年 🐭🐂🐯🐰🐲🐍🐴🐑🐵🐔🐶🐷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^GetAFN) (id responseObject);

@interface AFN : NSObject

+ (void)urlString:(NSString *)urlString getAFNdata:(GetAFN)getAFNdata;




@end
