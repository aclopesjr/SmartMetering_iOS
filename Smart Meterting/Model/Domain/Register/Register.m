//
//  Register.m
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/19/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import "Register.h"
#import "StorageArchive.h"
#import "AutoRegisterResult.h"

@implementation Register

@synthesize tokenId, clientTime, tags;

-(instancetype)init {
    if (self = [super init]) {
        
        //Loads auto register
        id autoRegisterResult = [StorageArchive load:[AutoRegisterResult class] withKey:[AutoRegisterResult keyForStorage]];
        if (autoRegisterResult != nil &&
            [autoRegisterResult class] == [AutoRegisterResult class] &&
            ((AutoRegisterResult *)autoRegisterResult).tokenId.length > 0) {
            //Sets saves auto register token id
            [self setTokenId:((AutoRegisterResult *)autoRegisterResult).tokenId];
        }
        
        NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
        NSNumber *timeStamp = [NSNumber numberWithInteger:timeInterval];
        [self setClientTime:[NSString stringWithFormat:@"%@", timeStamp]];
        
        [self setTags:[NSArray<NSString *> arrayWithObjects:@"iOS", @"Smart Metering", nil]];
    }
    return self;
}

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"tokenId" : @"tokenId",
             @"clientTime" : @"client_time",
             @"tags" : @"tag"
             };
}

@end
