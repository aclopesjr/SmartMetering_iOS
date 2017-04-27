//
//  RaiseUIOT.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/13/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AutoRegisterResult.h"
#import "ServiceRegister.h"
#import "ServiceRegisterResult.h"
#import "DataRegisterResult.h"

@interface RaiseUIOT : NSObject

typedef enum {
    RaiseUIOTGetLocation = 0,
    RaiseUIOTGetSignal = 1
} RaiseUIOTServiceType;

+(BOOL)isAutoRegistered;

+(void)autoRegister:(void (^_Nullable)(AutoRegisterResult * _Nullable autoRegisterResult))completionHandlerSuccessfuly andErroHandler:(void (^_Nullable)(NSError * _Nullable error))completionHandlerWithError;

+(void)registerAllServices:(void (^_Nullable)(ServiceRegisterResult * _Nullable serviceRegisterResult))completionHandlerSuccessfuly andCompletionHandlerWithError:(void (^_Nullable)(NSError * _Nullable error))completionHandlerWithError;

+(void)collectDataForAllServices:(void (^_Nonnull)(void))completionHandlerSuccessfuly andCompletionHandlerWithError:(void (^_Nullable)(NSError * _Nullable error))completionHandlerWithError;

+(void)listCollectedDataForService:(NSString *_Nonnull)serviceName andSuccessHandler:(void (^_Nonnull)(DataRegisterResult * _Nullable dataRegisterResult))completionHandlerSuccessfuly andCompletionHandlerWithError:(void (^_Nullable)(NSError * _Nullable error))completionHandlerWithError;

@end
