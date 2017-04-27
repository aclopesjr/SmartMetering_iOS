//
//  DataResult.m
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/21/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import "DataResult.h"
#import "MTLValueTransformer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation DataResult

@synthesize serviceId, clientTime, serverTime, tags, dataValues;

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"serviceId"   : @"service_id",
             @"clientTime"  : @"client_time",
             @"serverTime"  : @"server_time",
             @"tags"        : @"tag",
             @"dataValues"  : @"data_values"
             };
}

+(NSValueTransformer *)clientTimeJSONTransformer {
    return [MTLValueTransformer transformerUsingReversibleBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if (success) {
            NSTimeInterval timeInterval = [value doubleValue];
            return [NSDate dateWithTimeIntervalSince1970:timeInterval];
        }
        return nil;
    }];
}

+(NSValueTransformer *)serverTimeJSONTransformer {
    return [MTLValueTransformer transformerUsingReversibleBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if (success) {
            NSTimeInterval timeInterval = [value doubleValue];
            return [NSDate dateWithTimeIntervalSince1970:timeInterval];
        }
        return nil;
    }];
}

@end
