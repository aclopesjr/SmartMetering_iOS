//
//  ServiceRegister.m
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/16/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import "ServiceRegister.h"
#import "StorageArchive.h"
#import "AutoRegisterResult.h"

@implementation ServiceRegister

@synthesize services;

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"services" : @"services",
             @"tokenId" : @"tokenId",
             @"clientTime" : @"client_time",
             @"tags" : @"tag"
             };
}

+ (NSValueTransformer *)servicesJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[Service class]];
}

@end
