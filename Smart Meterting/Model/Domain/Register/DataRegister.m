//
//  DataRegister.m
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/19/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import "DataRegister.h"

@implementation DataRegister

@synthesize datas;

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"datas" : @"data",
             @"tokenId" : @"token",
             @"clientTime" : @"client_time",
             @"tags" : @"tag"
             };
}

+ (NSValueTransformer *)datasJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[Data class]];
}

@end
