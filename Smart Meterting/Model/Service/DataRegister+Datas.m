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

@implementation DataRegister(Datas)

+(DataRegister *)datasWithRoot {

    //Creates the Service Register Model
    DataRegister *dataRegister = [[DataRegister alloc] init];
    
    NSMutableArray<Data *> *datas = [NSMutableArray<Data *> arrayWithObjects:
                                           [DataRegister dataForLocation],
                                           [DataRegister dataForSignal],
                                           nil];
    [dataRegister setDatas:datas];
    
    return dataRegister;
}

+(Data *)dataForLocation {
    NSNumber *serviceId = [DataRegister getServiceId:SERVICE_NAME_FOR_LOCATION];
    
    Data *data = [[Data alloc] init];
    //Sets the service id
    [data setServiceId:serviceId];
    //Sets the input values
    NSMutableDictionary *inputValues = [[NSMutableDictionary alloc] init];
    [inputValues setObject:[NSNumber numberWithFloat:0.0] forKey:@"latitude"];
    [inputValues setObject:[NSNumber numberWithFloat:0.0] forKey:@"longitude"];
    [data setDataValues:inputValues];
    
    return data;
}

+(Data *)dataForSignal {
    NSNumber *serviceId = [DataRegister getServiceId:SERVICE_NAME_FOR_NETWORK_SIGNAL];
    
    Data *data = [[Data alloc] init];
    //Sets the service id
    [data setServiceId:serviceId];
    //Sets the input values
    NSMutableDictionary *inputValues = [[NSMutableDictionary alloc] init];
    [inputValues setObject:@"Good" forKey:@"signal"];
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
