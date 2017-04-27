//
//  ServiceRegisterResult.m
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/16/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import "ServiceRegisterResult.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation ServiceRegisterResult

@synthesize services, tokenId;

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [self init]) {
        [self setServices:[aDecoder decodeObjectForKey:@"services"]];
        [self setTokenId:[aDecoder decodeObjectForKey:@"tokenId"]];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:[self services] forKey:@"services"];
    [aCoder encodeObject:[self tokenId] forKey:@"tokenId"];
}

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"services" : @"services",
             @"tokenId" : @"tokenId"
             };
}

+ (NSValueTransformer *)servicesJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[ServiceResult class]];
}

#pragma mark: Storage Data
+ (NSString *)storagePath
{
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *storagePath = [cachesDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"com.iot.unb.data/%@", NSStringFromClass([self class])]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:storagePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:storagePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return storagePath;
}

+(NSString *)keyForStorage {
    return [NSString stringWithFormat:@"%@/%@.data", self.storagePath, @"service_register"];
}

@end
