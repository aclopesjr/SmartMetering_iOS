//
//  ServiceResult.m
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/16/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import "ServiceResult.h"

@implementation ServiceResult

@synthesize serviceId, name;

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [self init]) {
        [self setServiceId:[aDecoder decodeObjectForKey:@"serviceId"]];
        [self setName:[aDecoder decodeObjectForKey:@"name"]];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:[self serviceId] forKey:@"serviceId"];
    [aCoder encodeObject:[self name] forKey:@"name"];
}

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"serviceId" : @"service_id",
             @"name" : @"service_name"
             };
}

@end
