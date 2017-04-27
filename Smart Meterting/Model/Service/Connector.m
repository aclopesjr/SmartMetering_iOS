//
//  Connector.m
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/14/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import "Connector.h"

@implementation Connector

+(void)postRequest:(NSURL *)url andHTTPBody:(NSData *)json andSuccessHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable))completionHandlerSuccesfully andErrorHandler:(void (^)(NSError * _Nullable))completionHandlerWithError {
    
    //Creates the request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    //Sets the method as POST
    [request setHTTPMethod:@"POST"];
    //Sets Content-Type
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //Set the json lenght
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)json.length] forHTTPHeaderField:@"Content-Lenght"];
    
    //Sets the json into request body
    [request setHTTPBody:json];
    
    //Creates the task request
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable dataTask, NSURLResponse * _Nullable responseTask, NSError * _Nullable errorTask) {
        
        //Checks if any error happens
        if (errorTask != nil) {
            //Runs the error handle
            completionHandlerWithError(errorTask);
        } else {
            //Converts responseTask to NSHTTPURLResponse to get status code
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)responseTask;
            //Check if status code is successfully
            if (response != nil &&
                (response.statusCode >= 200 && response.statusCode < 300)) {
                completionHandlerSuccesfully(dataTask, responseTask);
            //Otherwise, prepare friendly error
            } else {
                //Converts from NSData to NSDiciotnary
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:dataTask options:NSJSONReadingMutableContainers error:nil];
                NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                [errorDetail setValue:[NSString stringWithFormat:@"%@", json] forKey:NSLocalizedDescriptionKey];
                NSError *friendlyError = [NSError errorWithDomain:@"RAISE UIOT" code:response.statusCode userInfo:errorDetail];
                
                completionHandlerWithError(friendlyError);
            }
        }
    }];
    [task resume];
}

+(void)getRequest:(NSURL *)url andSuccessHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable))completionHandlerSuccesfully andErrorHandler:(void (^)(NSError * _Nullable))completionHandlerWithError {
    
    //Creates the request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    //Sets the method as GET
    [request setHTTPMethod:@"GET"];
    //Sets Content-Type
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //Creates the task request
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable dataTask, NSURLResponse * _Nullable responseTask, NSError * _Nullable errorTask) {
        
        //Checks if any error happens
        if (errorTask != nil) {
            //Runs the error handle
            completionHandlerWithError(errorTask);
        } else {
            //Converts responseTask to NSHTTPURLResponse to get status code
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)responseTask;
            //Check if status code is successfully
            if (response != nil &&
                (response.statusCode >= 200 && response.statusCode < 300)) {
                completionHandlerSuccesfully(dataTask, responseTask);
                //Otherwise, prepare friendly error
            } else {
                //Converts from NSData to NSDiciotnary
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:dataTask options:NSJSONReadingMutableContainers error:nil];
                NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                [errorDetail setValue:[NSString stringWithFormat:@"%@", json] forKey:NSLocalizedDescriptionKey];
                NSError *friendlyError = [NSError errorWithDomain:@"RAISE UIOT" code:response.statusCode userInfo:errorDetail];
                
                completionHandlerWithError(friendlyError);
            }
        }
    }];
    [task resume];
}

@end
