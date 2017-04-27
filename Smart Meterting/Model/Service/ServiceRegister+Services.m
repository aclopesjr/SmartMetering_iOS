//
//  ServiceRegister+Services.m
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/20/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import "ServiceRegister+Services.h"

@implementation ServiceRegister(Services)

+(ServiceRegister *)servicesWithRoot {
    //Creates the Service Register Model
    ServiceRegister *serviceRegister = [[ServiceRegister alloc] init];
    
    NSMutableArray<Service *> *services = [NSMutableArray<Service *> arrayWithObjects:
                                           [ServiceRegister serviceWithLocation],
                                           [ServiceRegister serviceWithSignal],
                                           nil];
    [serviceRegister setServices:services];
    
    return serviceRegister;
}

+(Service *)serviceWithLocation {
    //Creates the location service
    Service *locationService = [Service alloc];
    [locationService setServiceName:SERVICE_NAME_FOR_LOCATION];
    //Defines the input parameters
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:@"float" forKey:@"latitude"];
    [parameters setValue:@"float" forKey:@"longitude"];
    [locationService setServiceParameters:parameters];
    //Defines the output parameters
    [locationService setServiceReturnType:[NSArray<NSString *> arrayWithObjects:@"float", @"float", nil]];
    
    return locationService;
}

+(Service *)serviceWithSignal {
    //Creates the location service
    Service *networkSignalService = [Service alloc];
    [networkSignalService setServiceName:SERVICE_NAME_FOR_NETWORK_SIGNAL];
    //Defines the input parameters
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:@"string" forKey:@"signal"];
    [networkSignalService setServiceParameters:parameters];
    //Defines the output parameters
    [networkSignalService setServiceReturnType:[NSArray<NSString *> arrayWithObjects:@"string", nil]];
    
    return networkSignalService;
}

@end
