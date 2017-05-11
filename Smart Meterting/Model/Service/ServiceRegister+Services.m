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
                                           [ServiceRegister serviceWithNetworkSignal],
                                           [ServiceRegister serviceWithBatteryLevel],
                                           [ServiceRegister serviceWithModel],
                                           [ServiceRegister serviceWithBranch],
                                           [ServiceRegister serviceWithOS],
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
    [parameters setValue:@"string" forKey:@"deviceId"];
    [locationService setServiceParameters:parameters];
    //Defines the output parameters
    [locationService setServiceReturnType:[NSArray<NSString *> arrayWithObjects:@"float", @"float", @"string", nil]];
    
    return locationService;
}

+(Service *)serviceWithNetworkSignal {
    //Creates the location service
    Service *networkSignalService = [Service alloc];
    [networkSignalService setServiceName:SERVICE_NAME_FOR_NETWORK_SIGNAL];
    //Defines the input parameters
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:@"string" forKey:@"carrier"];
    [parameters setValue:@"float" forKey:@"signal"];
    [parameters setValue:@"string" forKey:@"deviceId"];
    [networkSignalService setServiceParameters:parameters];
    //Defines the output parameters
    [networkSignalService setServiceReturnType:[NSArray<NSString *> arrayWithObjects:@"string", @"float", @"string", nil]];
    
    return networkSignalService;
}

+(Service *)serviceWithBatteryLevel {
    //Creates the location service
    Service *batteryService = [Service alloc];
    [batteryService setServiceName:SERVICE_NAME_FOR_BATTERY];
    //Defines the input parameters
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:@"string" forKey:@"state"];
    [parameters setValue:@"float" forKey:@"percentage"];
    [parameters setValue:@"string" forKey:@"deviceId"];
    [batteryService setServiceParameters:parameters];
    //Defines the output parameters
    [batteryService setServiceReturnType:[NSArray<NSString *> arrayWithObjects:@"string", @"float", @"string", nil]];
    
    return batteryService;
}

+(Service *)serviceWithModel {
    //Creates the model service
    Service *modelService = [Service alloc];
    [modelService setServiceName:SERVICE_NAME_FOR_MODEL];
    //Defines the input parameters
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:@"string" forKey:@"model"];
    [parameters setValue:@"string" forKey:@"deviceId"];
    [modelService setServiceParameters:parameters];
    //Defines the output parameters
    [modelService setServiceReturnType:[NSArray<NSString *> arrayWithObjects:@"string", @"string", nil]];
    
    return modelService;
}

+(Service *)serviceWithBranch {
    //Creates the branch service
    Service *branchService = [Service alloc];
    [branchService setServiceName:SERVICE_NAME_FOR_BRANCH];
    //Defines the input parameters
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:@"string" forKey:@"branch"];
    [parameters setValue:@"string" forKey:@"deviceId"];
    [branchService setServiceParameters:parameters];
    //Defines the output parameters
    [branchService setServiceReturnType:[NSArray<NSString *> arrayWithObjects:@"string", @"string", nil]];
    
    return branchService;
}

+(Service *)serviceWithOS {
    //Creates the Operation System service
    Service *osService = [Service alloc];
    [osService setServiceName:SERVICE_NAME_FOR_OS];
    //Defines the input parameters
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:@"string" forKey:@"os"];
    [parameters setValue:@"string" forKey:@"deviceId"];
    [osService setServiceParameters:parameters];
    //Defines the output parameters
    [osService setServiceReturnType:[NSArray<NSString *> arrayWithObjects:@"string", @"string", nil]];
    
    return osService;
}

@end
