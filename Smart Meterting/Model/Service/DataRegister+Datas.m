//
//  DataRegister+Services.m
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/20/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import "DataRegister+Datas.h"
#import "ServiceRegisterResult.h"
#import "StorageArchive.h"
#import "ServiceRegister+Services.h"
#import "UIDevice+Extention.h"

@implementation DataRegister(Datas)

+(DataRegister *)datasWithRoot {

    //Creates the Service Register Model
    DataRegister *dataRegister = [[DataRegister alloc] init];
    
    NSMutableArray<Data *> *datas = [NSMutableArray<Data *> arrayWithObjects:
                                            [DataRegister dataForLocation],
                                            [DataRegister dataForSignalLevel],
                                            [DataRegister dataForBatteryLevel],
                                            [DataRegister dataForModel],
                                            [DataRegister dataForBranch],
                                            [DataRegister dataForOS],
                                           nil];
    [dataRegister setDatas:datas];
    
    return dataRegister;
}

//Collect data for location
+(Data *)dataForLocation {
    //Gets the service id
    NSNumber *serviceId = [DataRegister getServiceId:SERVICE_NAME_FOR_LOCATION];
    if (serviceId == nil) {
        return nil;
    }
    
    Data *data = [[Data alloc] init];
    //Sets the service id
    [data setServiceId:serviceId];
    //Sets the input values
    NSMutableDictionary *inputValues = [[NSMutableDictionary alloc] init];
    [inputValues setObject:[UIDevice latitude] forKey:@"latitude"];
    [inputValues setObject:[UIDevice longitude] forKey:@"longitude"];
    [data setDataValues:inputValues];
    
    return data;
}

//Collect data for network signal level
+(Data *)dataForSignalLevel {
    //Gets the service id
    NSNumber *serviceId = [DataRegister getServiceId:SERVICE_NAME_FOR_NETWORK_SIGNAL];
    if (serviceId == nil) {
        return nil;
    }
    
    Data *data = [[Data alloc] init];
    //Sets the service id
    [data setServiceId:serviceId];
    //Sets the input values
    NSMutableDictionary *inputValues = [[NSMutableDictionary alloc] init];
    [inputValues setObject:[UIDevice carrierName] forKey:@"carrier"];
    [inputValues setObject:[UIDevice signalStrength] forKey:@"signal"];
    [data setDataValues:inputValues];
    
    return data;
}

//Collect data for power level
+(Data *)dataForBatteryLevel {
    //Gets the service id for battery
    NSNumber *serviceId = [DataRegister getServiceId:SERVICE_NAME_FOR_BATTERY];
    if (serviceId == nil) {
        return nil;
    }
    
    //Creates the data to register
    Data *data = [[Data alloc] init];
    //Sets the service id
    [data setServiceId:serviceId];
    //Sets the input values
    NSMutableDictionary *inputValues = [[NSMutableDictionary alloc] init];
    [inputValues setObject:[UIDevice batteryState] forKey:@"state"];
    [inputValues setObject:[UIDevice batteryPercentage] forKey:@"percentage"];
    [data setDataValues:inputValues];
    
    return data;
}

//Collect data for download and upload
+(Data *)dataForDownloadAndUpload {
    return nil;
}

//Collect data for loss package
+(Data *)dataForLossPackage {
    return nil;
}

//Collect data for device model
+(Data *)dataForModel {
    //Gets the service id for model
    NSNumber *serviceId = [DataRegister getServiceId:SERVICE_NAME_FOR_MODEL];
    if (serviceId == nil) {
        return nil;
    }
    
    //Creates the data to register
    Data *data = [[Data alloc] init];
    //Sets the service id
    [data setServiceId:serviceId];
    //Sets the input values
    NSMutableDictionary *inputValues = [[NSMutableDictionary alloc] init];
    [inputValues setObject:[UIDevice model] forKey:@"model"];
    [data setDataValues:inputValues];
    
    return data;
}

//Collect data for device branch
+(Data *)dataForBranch {
    //Gets the service id for branch
    NSNumber *serviceId = [DataRegister getServiceId:SERVICE_NAME_FOR_BRANCH];
    if (serviceId == nil) {
        return nil;
    }
    
    //Creates the data to register
    Data *data = [[Data alloc] init];
    //Sets the service id
    [data setServiceId:serviceId];
    //Sets the input values
    NSMutableDictionary *inputValues = [[NSMutableDictionary alloc] init];
    [inputValues setObject:[UIDevice branch] forKey:@"branch"];
    [data setDataValues:inputValues];
    
    return data;
}

//Collect data for operation system
+(Data *)dataForOS {
    //Gets the service id for operation system
    NSNumber *serviceId = [DataRegister getServiceId:SERVICE_NAME_FOR_OS];
    if (serviceId == nil) {
        return nil;
    }
    
    //Creates the data to register
    Data *data = [[Data alloc] init];
    //Sets the service id
    [data setServiceId:serviceId];
    //Sets the input values
    NSMutableDictionary *inputValues = [[NSMutableDictionary alloc] init];
    [inputValues setObject:[UIDevice operationSystem] forKey:@"os"];
    [data setDataValues:inputValues];
    
    return data;
}

+(NSNumber *)getServiceId:(NSString *)serviceName {
    //Loads Registered Services
    ServiceRegisterResult *serviceRegisterResult = [StorageArchive load:[ServiceRegisterResult class] withKey:[ServiceRegisterResult keyForStorage]];
    if (serviceRegisterResult != nil) {
        //Creates predicate to find the object.
        NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                  @"name like %@", serviceName];
        NSArray<ServiceResult *> *filteredServices = [[serviceRegisterResult services] filteredArrayUsingPredicate:predicate];
        
        if (filteredServices != nil && filteredServices.count > 0) {
            ServiceResult *firstServiceFiltered = [filteredServices objectAtIndex:0];
            return firstServiceFiltered.serviceId;
        }
    }
    return 0;
}

@end
