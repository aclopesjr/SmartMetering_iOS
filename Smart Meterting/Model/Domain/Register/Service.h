//
//  Service.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/16/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/MTLModel.h>
#import <Mantle/MTLJSONAdapter.h>

@interface Service : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *serviceName;
@property (nonatomic, copy) NSDictionary *serviceParameters;
@property (nonatomic, copy) NSArray<NSString *> *serviceReturnType;

@end
