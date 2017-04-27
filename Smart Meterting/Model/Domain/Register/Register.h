//
//  Register.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/19/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/MTLModel.h>
#import <Mantle/MTLJSONAdapter.h>

@interface Register : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *tokenId;
@property (nonatomic, copy) NSString *clientTime;
@property (nonatomic, copy) NSArray<NSString *> *tags;

@end
