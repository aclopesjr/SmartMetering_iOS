//
//  ServiceRegisterResult.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/16/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/MTLModel.h>
#import <Mantle/MTLJSONAdapter.h>
#import "ServiceResult.h"

@interface ServiceRegisterResult : MTLModel<MTLJSONSerializing, NSCoding>

@property (nonatomic, copy) NSArray<ServiceResult *> *services;
@property (nonatomic, copy) NSString *tokenId;

+(NSString *)keyForStorage;

@end
