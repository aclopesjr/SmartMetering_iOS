//
//  DataRegister+Services.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/20/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataRegister.h"

@interface DataRegister(Datas)

+(DataRegister *)datasWithRoot;
+(Data *)dataForLocation;
+(Data *)dataForSignal;
+(NSNumber *)getServiceId:(NSString *)serviceName;


@end
