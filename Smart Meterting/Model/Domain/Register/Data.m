//
//  Data.m
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/19/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import "Data.h"

@implementation Data

@synthesize serviceId, dataValues;

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"serviceId" : @"service_id",
             @"dataValues" : @"data_values"
             };
}

@end
