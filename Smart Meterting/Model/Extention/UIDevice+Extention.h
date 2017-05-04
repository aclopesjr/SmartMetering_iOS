//
//  UIDeviceExtention.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 5/1/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIDevice.h>
#import <CoreLocation/CoreLocation.h>

@interface UIDevice(UIDeviceExtention)

+(NSNumber *) latitude;
+(NSNumber *) longitude;

+(NSString *) batteryState;
+(NSNumber *) batteryPercentage;

+(NSString *) carrierName;
+(NSNumber *) signalStrength;

@end
