//
//  Connector.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/14/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Connector : NSObject

+(void)postRequest:(NSURL *_Nonnull)url andHTTPBody:(NSData *_Nonnull)json andSuccessHandler:(void (^_Nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response))completionHandlerSuccesfully andErrorHandler:(void (^_Nullable)(NSError * _Nullable error))completionHandlerWithError;

+(void)getRequest:(NSURL *_Nonnull)url andSuccessHandler:(void (^_Nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response))completionHandlerSuccesfully andErrorHandler:(void (^_Nullable)(NSError * _Nullable error))completionHandlerWithError;

@end
