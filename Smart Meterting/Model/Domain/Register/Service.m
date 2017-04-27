//
//  Service.m
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/16/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import "Service.h"

@implementation Service

@synthesize serviceName, serviceParameters, serviceReturnType;

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"serviceName" : @"name",
             @"serviceParameters" : @"parameters",
             @"serviceReturnType" : @"return_type"
             };
}


@end
