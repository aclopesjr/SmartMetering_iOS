//
//  SettingsViewController.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/20/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *autoRegisterStatus;
@property (strong, nonatomic) IBOutlet UIButton *forceAutoRegister;
@property (strong, nonatomic) IBOutlet UIButton *revalidateAutoRegister;
@property (strong, nonatomic) IBOutlet UIButton *forceDataCollection;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityForStatus;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityForAutoRegisterButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityForValidateButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityForDataCollectionButton;

@end
