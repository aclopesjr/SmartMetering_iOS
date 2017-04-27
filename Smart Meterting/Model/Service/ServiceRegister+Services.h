//
//  ServiceRegister+Services.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/20/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#define SERVICE_NAME_FOR_LOCATION           @"GetLocation"
#define SERVICE_NAME_FOR_NETWORK_SIGNAL     @"GetNetworkSignal"

#import <Foundation/Foundation.h>
#import "ServiceRegister.h"

@interface ServiceRegister(Services)

+(ServiceRegister *)servicesWithRoot;
+(Service *)serviceWithLocation;
+(Service *)serviceWithSignal;

@end
