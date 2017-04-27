//
//  DataRegisterResult.m
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/21/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import "DataRegisterResult.h"

@implementation DataRegisterResult

@synthesize datas;

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"datas" : @"values"
             };
}

+ (NSValueTransformer *)datasJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[DataResult class]];
}

@end
