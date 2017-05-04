//
//  AppDelegate.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/11/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;

+(AppDelegate *) sharedInstance;

@end

