//
//  DataRegisterResult.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/21/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/MTLModel.h>
#import <Mantle/MTLJSONAdapter.h>
#import "DataResult.h"

@interface DataRegisterResult : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSArray<DataResult *> *datas;

@end
