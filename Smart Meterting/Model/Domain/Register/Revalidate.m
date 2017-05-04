//
//  Revalidate.m
//  Smart Meterting
//
//  Created by Antonio Lopes on 5/1/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import "Revalidate.h"
#import "StorageArchive.h"
#import "ServiceRegisterResult.h"
#import "ServiceResult.h"

@implementation Revalidate

@synthesize tokenId, services;

-(instancetype)init {
    if (self = [super init]) {
        ServiceRegisterResult * serviceRegisterResult = [StorageArchive load:[ServiceRegisterResult class] withKey:[ServiceRegisterResult keyForStorage]];
        
        NSMutableArray<NSNumber *> *mutableServices = [[NSMutableArray<NSNumber *> alloc] init];
        for (ServiceResult *service in [serviceRegisterResult services]) {
            [mutableServices addObject:[service serviceId]];
        }
        self.services = [[NSArray<NSNumber*> alloc] initWithArray:mutableServices];
    }
    return self;
}

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"tokenId" : @"tokenId",
             @"services" : @"services"
             };
}

@end
