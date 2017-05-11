//
//  UIDeviceExtention.m
//  Smart Meterting
//
//  Created by Antonio Lopes on 5/1/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import "UIDevice+Extention.h"
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "AppDelegate.h"

@implementation UIDevice(UIDeviceExtention)

+(NSNumber *) latitude {
    CLLocation *location = [[AppDelegate sharedInstance] currentLocation];
    return [NSNumber numberWithDouble:location.coordinate.latitude];
}

+(NSNumber *) longitude {
    CLLocation *location = [[AppDelegate sharedInstance] currentLocation];
    return [NSNumber numberWithDouble:location.coordinate.longitude];
}

+(NSString *) batteryState {
    //Gets the battery monitoring
    bool isBatteryMonitoring = [[UIDevice currentDevice] isBatteryMonitoringEnabled];
    //Starts monitoring the battery
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:TRUE];
    
    //Gets the battery state
    NSString *result = nil;
    switch ([[UIDevice currentDevice] batteryState]) {
        case UIDeviceBatteryStateUnplugged:
            result = @"Unplugged";
            break;
        case UIDeviceBatteryStateCharging:
            result = @"Charging";
            break;
        case UIDeviceBatteryStateFull:
            result = @"Full";
            break;
        case UIDeviceBatteryStateUnknown:
        default:
            result = @"Unknown";
            break;
    }
    //Sets the old battery monitoring
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:isBatteryMonitoring];
    return result;
}

+(NSNumber *) batteryPercentage {
    //Gets the battery monitoring
    bool isBatteryMonitoring = [[UIDevice currentDevice] isBatteryMonitoringEnabled];
    //Starts monitoring the battery
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:TRUE];
    //Gets the battery level percentage
    NSNumber *percentage = [NSNumber numberWithFloat:[[UIDevice currentDevice] batteryLevel] * 100];
    //Sets the old battery monitoring
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:isBatteryMonitoring];
    return percentage;
}

+(NSString *) carrierName {
    //Gets the carrier name (TIM, VIVO, etc.)
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [networkInfo subscriberCellularProvider];
    
    return carrier.carrierName;
}

+(NSNumber *) signalStrength {
    //Gets the signal strenght
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSString *dataNetworkItemView = nil;
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarSignalStrengthItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    int signalStrength = [[dataNetworkItemView valueForKey:@"signalStrengthBars"] intValue];
    return [NSNumber numberWithInt:signalStrength];
}

+(NSString *) model {
    return [[UIDevice currentDevice] model];
}

+(NSString *) branch {
    return @"Apple";
}

+(NSString *) operationSystem {
    return [NSString stringWithFormat:@"%@ %@", [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]];
}

+(NSString *) uniqueIdentifier {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

@end
