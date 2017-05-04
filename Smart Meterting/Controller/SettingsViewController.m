//
//  SettingsViewController.m
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/20/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import "SettingsViewController.h"
#import "RaiseUIOT.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self registerStatusDidUpdate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark Status
-(void)registerStatusDidUpdate {
    [[self autoRegisterStatus] setText:@"Verifying Auto Register!"];
    [[self autoRegisterStatus] setTextColor:[UIColor blackColor]];
    //Starts indicating activity for status
    [[self activityForStatus] startAnimating];
    
    [[self forceAutoRegister] setEnabled:FALSE];
    [[self forceAutoRegister] setAlpha:0.5];
    [[self revalidateAutoRegister] setEnabled:FALSE];
    [[self revalidateAutoRegister] setAlpha:0.5];
    [[self forceDataCollection] setEnabled:FALSE];
    [[self forceDataCollection] setAlpha:0.5];
    
    [RaiseUIOT willNeedToValidateAutoRegister:^{
        //It is registered, but needs to validate
        if ([RaiseUIOT isAutoRegistered]) {
            [[self autoRegisterStatus] setText:@"Device needs to validate auto register!"];
            //Enable Auto Register Button to Auto Register process
            [[self revalidateAutoRegister] setEnabled:TRUE];
            [[self revalidateAutoRegister] setAlpha:1.0];
        //It is not registered.
        } else {
            [[self autoRegisterStatus] setText:@"Device is not currently auto registered!"];
            //Enable Auto Register Button to Auto Register process
            [[self forceAutoRegister] setEnabled:TRUE];
            [[self forceAutoRegister] setAlpha:1.0];
        }
        [[self autoRegisterStatus] setTextColor:[UIColor redColor]];
        //Stops indicate activity for status
        [[self activityForStatus] stopAnimating];
    } andNoNeedsHandler:^{
        //It is registerd.
        [[self autoRegisterStatus] setText:@"Device is currently auto registered!"];
        [[self autoRegisterStatus] setTextColor:[UIColor greenColor]];
        //Enable Data Collection Button to Collect Data process
        [[self forceDataCollection] setEnabled:TRUE];
        [[self forceDataCollection] setAlpha:1.0];
        //Stops indicate activity for status
        [[self activityForStatus] stopAnimating];
    } andErroHandler:^(NSError * _Nullable error) {
        //Throws error alert
        UIAlertController * alert = [[UIAlertController
                                      alertControllerWithTitle:@"Error Auto Registering!"
                                      message:[error localizedDescription]
                                      preferredStyle:UIAlertControllerStyleAlert] init];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                  style:UIAlertActionStyleDefault
                                                handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self registerStatusDidUpdate];
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        //Stops indicate activity for status
        [[self activityForStatus] stopAnimating];
    }];
}

#pragma mark Buttons
- (IBAction)onForceAutoRegisterClick:(UIButton *)sender {
    //Starts activity indicator for Auto Register
    [[self activityForAutoRegisterButton] startAnimating];
    //Starts the process of auto registering
    [RaiseUIOT autoRegister:^(AutoRegisterResult * _Nullable autoRegisterResult) {
        //Registers all services
        [RaiseUIOT registerAllServices:^(ServiceRegisterResult * _Nullable serviceRegisterResult) {
            //
            NSMutableString *message = [[NSMutableString alloc] init];
            [message appendString:@"The device has successfuly been auto registered with services: "];
            for (ServiceResult *service in serviceRegisterResult.services) {
                [message appendString:service.name];
                if ([[serviceRegisterResult services] lastObject] != service) {
                    [message appendString:@", "];
                }
            }
            //Throws successfuly alert
            UIAlertController * alert = [[UIAlertController
                                          alertControllerWithTitle:@"Auto Registered Successfuly"
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert] init];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"Close"
                                                      style:UIAlertActionStyleDefault
                                                    handler:nil]];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            [self registerStatusDidUpdate];
            //Stops activity indicator for Auto Register
            [[self activityForAutoRegisterButton] stopAnimating];
            
        } andCompletionHandlerWithError:^(NSError * _Nullable error) {
            //Stops activity indicator for Auto Register
            [[self activityForAutoRegisterButton] stopAnimating];
            //Throws error alert
            UIAlertController * alert = [[UIAlertController
                                          alertControllerWithTitle:@"Error Registering Services!"
                                          message:[error localizedDescription]
                                          preferredStyle:UIAlertControllerStyleAlert] init];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"Close"
                                                      style:UIAlertActionStyleDefault
                                                    handler:nil]];
            
            [self presentViewController:alert animated:YES completion:nil];
        }];
    } andErroHandler:^(NSError * _Nullable error) {
        //Throws error alert
        UIAlertController * alert = [[UIAlertController
                                      alertControllerWithTitle:@"Error Auto Registering!"
                                      message:[error localizedDescription]
                                      preferredStyle:UIAlertControllerStyleAlert] init];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"Close"
                                                  style:UIAlertActionStyleDefault
                                                handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
        //Stops activity indicator for Auto Register
        [[self activityForAutoRegisterButton] stopAnimating];
    }];
}

- (IBAction)onRevalidateAutoRegisterClick:(UIButton *)sender {
    //Starts activity indicator for Revalidating Auto Register
    [[self activityForValidateButton] startAnimating];
    //Starts the process of Revalita Autor Register
    [RaiseUIOT revalidateAutoRegister:^(AutoRegisterResult * _Nullable autoRegisterResult) {
        //Throws successfuly alert
        UIAlertController * alert = [[UIAlertController
                                      alertControllerWithTitle:@"Auto Register Revalidated Successfuly"
                                      message:@"The auto register has successfuly been revalidated!"
                                      preferredStyle:UIAlertControllerStyleAlert] init];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"Close"
                                                  style:UIAlertActionStyleDefault
                                                handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
        [self registerStatusDidUpdate];
        //Stops activity indicator for Revalidating Auto Register
        [[self activityForValidateButton] stopAnimating];
    } andErroHandler:^(NSError * _Nullable error) {
        //Throws error alert
        UIAlertController * alert = [[UIAlertController
                                      alertControllerWithTitle:@"Error Revalidating Auto Register!"
                                      message:[error localizedDescription]
                                      preferredStyle:UIAlertControllerStyleAlert] init];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"Close"
                                                  style:UIAlertActionStyleDefault
                                                handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        //Stops activity indicator for Revalidating Auto Register
        [[self activityForValidateButton] stopAnimating];
    }];
}

- (IBAction)onForceDataCollection:(UIButton *)sender {
    //Starts activity indicator for Collecting
    [[self activityForDataCollectionButton] startAnimating];
    //
    [RaiseUIOT collectDataForAllServices:^{
        //Throws error alert
        UIAlertController * alert = [[UIAlertController
                                      alertControllerWithTitle:@"Datas Collected Successfuly!"
                                      message:@"Datas have all successfuly been collected!"
                                      preferredStyle:UIAlertControllerStyleAlert] init];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"Close"
                                                  style:UIAlertActionStyleDefault
                                                handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        //Stops activity indicator for Collecting Data
        [[self activityForDataCollectionButton] stopAnimating];
    } andCompletionHandlerWithError:^(NSError * _Nullable error) {
        //Throws error alert
        UIAlertController * alert = [[UIAlertController
                                      alertControllerWithTitle:@"Error Collecting Datas!"
                                      message:[error localizedDescription]
                                      preferredStyle:UIAlertControllerStyleAlert] init];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"Close"
                                                  style:UIAlertActionStyleDefault
                                                handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        //Stops activity indicator for Collecting Data
        [[self activityForDataCollectionButton] stopAnimating];
    }];
}


@end
