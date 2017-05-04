//
//  Revalidate.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 5/1/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/MTLModel.h>
#import <Mantle/MTLJSONAdapter.h>
#import "Register.h"

@interface Revalidate : Register

@property (nonatomic, copy) NSArray<NSNumber *> *services;

@end
