//
//  AutoRegister.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/15/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/MTLModel.h>
#import <Mantle/MTLJSONAdapter.h>

@interface AutoRegisterResult : MTLModel<MTLJSONSerializing, NSCoding>

@property (nonatomic, copy) NSString *tokenId;

+(NSString *)keyForStorage;

@end
