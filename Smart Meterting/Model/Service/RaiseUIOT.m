//
//  RaiseUIOT.m
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/13/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import "RaiseUIOT.h"
#import <UIKit/UIKit.h>
#import <Mantle/Mantle.h>
#import "Connector.h"
#import "StorageArchive.h"
#import "AutoRegister.h"
#import "ServiceRegister.h"
#import "ServiceRegister+Services.h"
#import "DataRegister.h"
#import "DataRegister+Datas.h"
#import "Data.h"

//Release Enviroment
//NSString *const UIOT_HOST           = @"raise.uiot.com.br";
//Test Enviroment
NSString *const UIOT_HOST           = @"homol.redes.unb.br/uiot-raise";
NSString *const CLIENT_REGISTER     = @"client/register";
NSString *const SERVICE_REGISTER    = @"service/register";
NSString *const DATA_REGISTER       = @"data/register";
NSString *const DATA_LIST           = @"data/list";

@implementation RaiseUIOT

+(BOOL)isAutoRegistered {
    
    id autoRegisterResult = [StorageArchive load:[AutoRegisterResult class] withKey:[AutoRegisterResult keyForStorage]];
    if (autoRegisterResult != nil &&
        [autoRegisterResult class] == [AutoRegisterResult class] &&
        ((AutoRegisterResult *)autoRegisterResult).tokenId.length > 0) {
        return YES;
    }
    
    return FALSE;
}

+(void)autoRegister:(void (^)(AutoRegisterResult * _Nullable))completionHandlerSuccessfuly andErroHandler:(void (^)(NSError * _Nullable))completionHandlerWithError {
    
    //Defines the absolute url
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@", UIOT_HOST, CLIENT_REGISTER]];
    
    //Creates device's info object
    AutoRegister *autoRegister = [[AutoRegister alloc] init];
    
    //Serializes device's info object in json
    NSError *erro = nil;
    NSDictionary *jsonDict = [MTLJSONAdapter JSONDictionaryFromModel:autoRegister error:&erro];
    NSLog(@"Auto Register\n%@", jsonDict);
    
    //Converts json in data to be sent in http body
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:&erro];
    
    //Does the post request
    [Connector postRequest:url andHTTPBody:jsonData andSuccessHandler:^(NSData * _Nullable connectorData, NSURLResponse * _Nullable response) {
        
        //Converts from NSData to NSDiciotnary
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:connectorData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"Auto Register Result\n%@", json);
        
        //Deserializes the json to AutoRegister object
        NSError *deserializationError = nil;
        AutoRegisterResult *autoRegisterResult = [MTLJSONAdapter modelOfClass:[AutoRegisterResult class] fromJSONDictionary:json error:&deserializationError];
        
        //Checks if there is any error on deserialization process
        if (deserializationError != nil) {
            completionHandlerWithError(deserializationError);
        }
        
        //Persists the AutoRegister data
        [StorageArchive persist:autoRegisterResult withKey:[AutoRegisterResult keyForStorage]];
        
        completionHandlerSuccessfuly(autoRegisterResult);
    } andErrorHandler:^(NSError * _Nullable connectorError) {
        completionHandlerWithError(connectorError);
    }];
}

+(void)registerAllServices:(void (^_Nullable)(ServiceRegisterResult * _Nullable serviceRegisterResult))completionHandlerSuccessfuly andCompletionHandlerWithError:(void (^_Nullable)(NSError * _Nullable error))completionHandlerWithError {
    
    //Defines the absolute url
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@", UIOT_HOST, SERVICE_REGISTER]];
    
    //Serializes device's info object in json
    NSError *serializationError = nil;
    ServiceRegister *serviceWithRoot = [ServiceRegister servicesWithRoot];
    NSDictionary *json = [MTLJSONAdapter JSONDictionaryFromModel:serviceWithRoot error:&serializationError];
    if (serializationError == nil) {
        NSLog(@"Service\n%@", json);
    }
    
    //Converts json in data to be sent in http body
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:0 error:&serializationError];
    
    [Connector postRequest:url andHTTPBody:jsonData andSuccessHandler:^(NSData * _Nullable connectorData, NSURLResponse * _Nullable response) {
        
        //Converts from NSData to NSDiciotnary
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:connectorData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"Service Register Result\n%@", json);
        
        //Deserializes the json to AutoRegister object
        NSError *deserializationError = nil;
        ServiceRegisterResult *serviceRegisterResult = [MTLJSONAdapter modelOfClass:[ServiceRegisterResult class] fromJSONDictionary:json error:&deserializationError];
        
        //Checks if there is any error on deserialization process
        if (deserializationError != nil) {
            completionHandlerWithError(deserializationError);
        }
        
        //Persists the ServiceRegisterResult data
        [StorageArchive persist:serviceRegisterResult withKey:[ServiceRegisterResult keyForStorage]];
        
        completionHandlerSuccessfuly(serviceRegisterResult);
    } andErrorHandler:^(NSError * _Nullable connectorError) {
        completionHandlerWithError(connectorError);
    }];
}

+(void)collectDataForAllServices:(void (^_Nonnull)(void))completionHandlerSuccessfuly andCompletionHandlerWithError:(void (^_Nullable)(NSError * _Nullable error))completionHandlerWithError {

    //Defines the absolute url
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@", UIOT_HOST, DATA_REGISTER]];
    
    //Serializes device's info object in json
    NSError *serializationError = nil;
    DataRegister *datasWithRoot = [DataRegister datasWithRoot];
    NSDictionary *json = [MTLJSONAdapter JSONDictionaryFromModel:datasWithRoot error:&serializationError];
    if (serializationError == nil) {
        NSLog(@"Service\n%@", json);
    }
    
    //Converts json in data to be sent in http body
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:0 error:&serializationError];
 
    [Connector postRequest:url andHTTPBody:jsonData andSuccessHandler:^(NSData * _Nullable connectorData, NSURLResponse * _Nullable response) {
        
        //Converts from NSData to NSDiciotnary
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:connectorData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"Data Register Result\n%@", json);
        
        completionHandlerSuccessfuly();
    } andErrorHandler:^(NSError * _Nullable connectorError) {
        completionHandlerWithError(connectorError);
    }];
}

+(void)listCollectedDataForService:(NSString *_Nonnull)serviceName andSuccessHandler:(void (^_Nonnull)(DataRegisterResult * _Nullable dataRegisterResult))completionHandlerSuccessfuly andCompletionHandlerWithError:(void (^_Nullable)(NSError * _Nullable error))completionHandlerWithError {
    
    //Gets the token
    NSString *token = nil;
    AutoRegisterResult *autoRegisterResult = [StorageArchive load:[AutoRegisterResult class] withKey:[AutoRegisterResult keyForStorage]];
    if (autoRegisterResult != nil) {
        token = autoRegisterResult.tokenId;
    }
    //
    NSNumber *locationServiceId = [DataRegister getServiceId:serviceName];
    
    //Defines the absolute url
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@?tokenId=%@&service_id=%@", UIOT_HOST, DATA_LIST, token, locationServiceId]];
    
    [Connector getRequest:url andSuccessHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response) {
        //Converts from NSData to NSDiciotnary
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"Data Collected\n%@", json);
        
        //Deserializes the json to AutoRegister object
        NSError *deserializationError = nil;
        DataRegisterResult *dataCollected = [MTLJSONAdapter modelOfClass:[DataRegisterResult class] fromJSONDictionary:json error:&deserializationError];
        
        //Checks if there is any error on deserialization process
        if (deserializationError != nil) {
            completionHandlerWithError(deserializationError);
        }
        
        completionHandlerSuccessfuly(dataCollected);
    } andErrorHandler:^(NSError * _Nullable error) {
        completionHandlerWithError(error);
    }];
}
@end
