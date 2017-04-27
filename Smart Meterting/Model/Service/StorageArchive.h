//
//  StorageArchive.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/15/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/MTLModel.h>

@interface StorageArchive : NSObject

+(BOOL)persist:(id<NSCoding>)objectToStore withKey:(NSString *)key;
+(id)load:(Class)modelClass withKey:(NSString *)key;

@end
