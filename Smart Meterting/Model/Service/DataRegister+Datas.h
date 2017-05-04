//
//  DataRegister+Services.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/20/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataRegister.h"

@interface DataRegister(Datas)

+(DataRegister *)datasWithRoot;
+(NSNumber *)getServiceId:(NSString *)serviceName;
+(Data *)dataForLocation;
+(Data *)dataForSignalLevel;
+(Data *)dataForBatteryLevel;
+(Data *)dataForDownloadAndUpload;
+(Data *)dataForLossPackage;
+(Data *)dataForDeviceModel;
+(Data *)dataForDeviceBranch;
+(Data *)dataForOS;


@end
