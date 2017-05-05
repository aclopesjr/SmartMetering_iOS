//
//  ServiceRegister+Services.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/20/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#define SERVICE_NAME_FOR_LOCATION           @"GetLocation"
#define SERVICE_NAME_FOR_NETWORK_SIGNAL     @"GetNetworkSignal"
#define SERVICE_NAME_FOR_BATTERY            @"GetBatteryLevel"
#define SERVICE_NAME_FOR_NETWORK_TRAFFIC    @"GetNetworkTraffic"
#define SERVICE_NAME_FOR_LOSS_PACKAGE       @"GetLossPackage"
#define SERVICE_NAME_FOR_MODEL              @"GetModel"
#define SERVICE_NAME_FOR_BRANCH             @"GetBranch"
#define SERVICE_NAME_FOR_OS                 @"GetOperationSystem"

#import <Foundation/Foundation.h>
#import "ServiceRegister.h"

@interface ServiceRegister(Services)

+(ServiceRegister *)servicesWithRoot;
+(Service *)serviceWithLocation;
+(Service *)serviceWithNetworkSignal;
+(Service *)serviceWithBatteryLevel;
+(Service *)serviceWithModel;
+(Service *)serviceWithBranch;
+(Service *)serviceWithOS;

@end
