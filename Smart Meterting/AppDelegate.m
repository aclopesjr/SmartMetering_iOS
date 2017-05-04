//
//  AppDelegate.m
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/11/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import "AppDelegate.h"
#import "RaiseUIOT.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize locationManager, currentLocation;
static AppDelegate *instance = nil;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    instance = self;
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager setDelegate:self];
    [self.locationManager setDistanceFilter:100.0];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
    [self.locationManager setAllowsBackgroundLocationUpdates:TRUE];
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    self.currentLocation = locationManager.location;
    
    [self.locationManager startUpdatingLocation];
    
    return YES;
}

+(AppDelegate *) sharedInstance {
    return instance;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark Background Refresh
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //
    self.currentLocation = [locations lastObject];
    //
    NSLog(@"Location started");
    NSDate *fetchStart = [NSDate date];
    
    [RaiseUIOT collectDataForAllServices:^{
        NSDate *fetchEnd = [NSDate date];
        NSTimeInterval timeElapsed = [fetchEnd timeIntervalSinceDate:fetchStart];
        NSLog(@"Background Location Duration: %f seconds", timeElapsed);
        NSLog(@"Location Finished");
    } andCompletionHandlerWithError:^(NSError * _Nullable error) {
        //Datas are not collected
        NSDate *fetchEnd = [NSDate date];
        NSTimeInterval timeElapsed = [fetchEnd timeIntervalSinceDate:fetchStart];
        NSLog(@"Background Location Duration: %f seconds", timeElapsed);
        NSLog(@"Location Finished");
    }];
}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"Fetch started");
    NSDate *fetchStart = [NSDate date];
    
    [RaiseUIOT collectDataForAllServices:^{
        //Datas are collected successfuly
        completionHandler(UIBackgroundFetchResultNewData);
        
        NSDate *fetchEnd = [NSDate date];
        NSTimeInterval timeElapsed = [fetchEnd timeIntervalSinceDate:fetchStart];
        NSLog(@"Background Fetch Duration: %f seconds", timeElapsed);
        NSLog(@"Fetch Finished");
    } andCompletionHandlerWithError:^(NSError * _Nullable error) {
        //Datas are not collected
        NSDate *fetchEnd = [NSDate date];
        NSTimeInterval timeElapsed = [fetchEnd timeIntervalSinceDate:fetchStart];
        NSLog(@"Background Fetch Duration: %f seconds", timeElapsed);
        NSLog(@"Fetch Finished");
    }];
}

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Sets 1 hour of interval
    [application setMinimumBackgroundFetchInterval:3600];
    //Sets 30 seconds of interval
    //[application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    return true;
}
@end
