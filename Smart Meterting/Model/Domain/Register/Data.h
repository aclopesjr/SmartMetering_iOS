//
//  Data.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/19/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/MTLModel.h>
#import <Mantle/MTLJSONAdapter.h>

@interface Data : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *serviceId;
@property (nonatomic, copy) NSDictionary *dataValues;

@end
