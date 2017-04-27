//
//  ServiceRegister.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/16/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/MTLModel.h>
#import <Mantle/MTLJSONAdapter.h>
#import "Register.h"
#import "Service.h"

@interface ServiceRegister : Register

@property (nonatomic, copy) NSArray<Service *> *services;

@end
