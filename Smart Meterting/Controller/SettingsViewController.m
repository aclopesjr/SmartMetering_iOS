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
    if ([RaiseUIOT isAutoRegistered]) {
        [[self autoRegisterStatus] setText:@"Device is currently auto registered!"];
        [[self autoRegisterStatus] setTextColor:[UIColor greenColor]];
    } else {
        [[self autoRegisterStatus] setText:@"Device is not currently auto registered!"];
        [[self autoRegisterStatus] setTextColor:[UIColor redColor]];
    }
}

#pragma mark Buttons
- (IBAction)onForceAutoRegisterClick:(UIButton *)sender {
    
    [RaiseUIOT autoRegister:^(AutoRegisterResult * _Nullable autoRegisterResult) {
        
        //Registers all services
        [RaiseUIOT registerAllServices:^(ServiceRegisterResult * _Nullable serviceRegisterResult) {
           
            NSMutableString *message = [[NSMutableString alloc] init];
            [message appendString:@"The device has been successfuly auto registered with services: "];
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
            
        } andCompletionHandlerWithError:^(NSError * _Nullable error) {
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
    }];
}

- (IBAction)onForceDataCollection:(UIButton *)sender {
   
    [RaiseUIOT collectDataForAllServices:^{
        //Throws error alert
        UIAlertController * alert = [[UIAlertController
                                      alertControllerWithTitle:@"Datas Collected Successfuly!"
                                      message:@"Datas have all been collected successfuly!"
                                      preferredStyle:UIAlertControllerStyleAlert] init];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"Close"
                                                  style:UIAlertActionStyleDefault
                                                handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
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
    }];
}


@end
