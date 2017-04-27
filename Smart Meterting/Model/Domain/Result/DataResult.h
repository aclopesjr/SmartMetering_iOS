//
//  DataResult.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/21/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/MTLModel.h>
#import <Mantle/MTLJSONAdapter.h>

@interface DataResult : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *serviceId;
@property (nonatomic, copy) NSDate *clientTime;
@property (nonatomic, copy) NSDate *serverTime;
@property (nonatomic, copy) NSArray<NSString *> *tags;
@property (nonatomic, copy) NSDictionary *dataValues;

@end
