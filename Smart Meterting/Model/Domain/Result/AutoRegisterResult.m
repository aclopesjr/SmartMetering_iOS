//
//  AutoRegister.m
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/15/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import "AutoRegisterResult.h"
#import <Mantle/MTLValueTransformer.h>

@implementation AutoRegisterResult

@synthesize tokenId;

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [self init]) {
        [self setTokenId:[aDecoder decodeObjectForKey:@"tokenId"]];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:[self tokenId] forKey:@"tokenId"];
}

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"tokenId" : @"tokenId"
             };
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
    return [NSString stringWithFormat:@"%@/%@.data", self.storagePath, @"auto_register"];
}

@end
