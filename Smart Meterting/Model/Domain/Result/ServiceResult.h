//
//  ServiceResult.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/16/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/MTLModel.h>
#import <Mantle/MTLJSONAdapter.h>

@interface ServiceResult : MTLModel<MTLJSONSerializing, NSCoding>

@property (nonatomic, copy) NSNumber *serviceId;
@property (nonatomic, copy) NSString *name;

@end
