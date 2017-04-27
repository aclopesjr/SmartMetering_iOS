//
//  DataRegister.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/19/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/MTLModel.h>
#import <Mantle/MTLJSONAdapter.h>
#import "Register.h"
#import "Data.h"

@interface DataRegister : Register

@property (nonatomic, copy) NSArray<Data *> *datas;

@end
