//
//  Device.m
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/11/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import "AutoRegister.h"
#import <UIKit/UIKit.h>

@implementation AutoRegister

@synthesize name, chipset, mac, serial, processor, channel, clientTime, tags;

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name" : @"name",
             @"chipset" : @"chipset",
             @"mac" : @"mac",
             @"serial" : @"serial",
             @"processor" : @"processor",
             @"channel" : @"channel",
             @"clientTime" : @"client_time",
             @"tags" : @"tag"
             };
}

-(instancetype)init {
    if (self = [super init]) {
        
        [self setName:[[UIDevice currentDevice] name]];
        [self setChipset:[[UIDevice currentDevice] model]];
        [self setSerial:[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
        [self setProcessor:@"ARM"];
        [self setMac:[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
        [self setChannel:@"unknown"];
        
        NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
        NSNumber *timeStamp = [NSNumber numberWithInteger:timeInterval];
        [self setClientTime:[NSString stringWithFormat:@"%@", timeStamp]];
        
        [self setTags:[NSArray<NSString *> arrayWithObjects:@"iOS", @"Auto Register", nil]];
    }
    return self;
}


@end
