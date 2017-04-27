//
//  StorageArchive.m
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/15/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import "StorageArchive.h"

@implementation StorageArchive

+(BOOL)persist:(id<NSCoding>)objectToStore withKey:(NSString *)key {
    
    @try {
        //Persists the AutoRegister data
        NSMutableData *mutableData = [NSMutableData data];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableData];
        
        //Encodes the object
        [objectToStore encodeWithCoder:archiver];
        [archiver finishEncoding];
        
        //Saves the data
        [mutableData writeToFile:key atomically:YES];
    } @catch (NSException *exception) {
        return NO;
    }
    
    return YES;
}

+(id)load:(Class)modelClass withKey:(NSString *)key {
    
    id loaded = nil;
    //Finds the object
    if ( [[NSFileManager defaultManager] fileExistsAtPath:key]) {
        
        //Gets the object
        NSData *data = [NSData dataWithContentsOfFile:key];
        
        //Unarchives the object
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        //Creates new instance with the unarchive object
        loaded = [[[modelClass class] alloc] initWithCoder:unarchiver];
        [unarchiver finishDecoding];
    }
    return loaded;
}

@end
