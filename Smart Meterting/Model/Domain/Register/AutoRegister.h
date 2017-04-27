//
//  Device.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/11/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/MTLModel.h>
#import <Mantle/MTLJSONAdapter.h>

@interface AutoRegister : MTLModel<MTLJSONSerializing>
    
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *chipset;
@property (nonatomic, copy) NSString *mac;
@property (nonatomic, copy) NSString *serial;
@property (nonatomic, copy) NSString *processor;
@property (nonatomic, copy) NSString *channel;
@property (nonatomic, copy) NSString *clientTime;
@property (nonatomic, copy) NSArray<NSString *> *tags;

@end
