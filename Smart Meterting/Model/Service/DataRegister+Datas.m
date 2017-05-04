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
                                           nil];
    [dataRegister setDatas:datas];
    
    return dataRegister;
}

//Collect data for location
+(Data *)dataForLocation {
    NSNumber *serviceId = [DataRegister getServiceId:SERVICE_NAME_FOR_LOCATION];
    
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
    NSNumber *serviceId = [DataRegister getServiceId:SERVICE_NAME_FOR_NETWORK_SIGNAL];
    
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
+(Data *)dataForDeviceModel {
    //[self setChipset:[[UIDevice currentDevice] model]];
    return nil;
}

//Collect data for device branch
+(Data *)dataForDeviceBranch {
    return nil;
}

//Collect data for operation system
+(Data *)dataForOS {
    return nil;
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
