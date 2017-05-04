//
//  MainViewController.m
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/11/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import "MainViewController.h"
#import "RaiseUIOT.h"
#import "AutoRegisterResult.h"
#import "ServiceRegister.h"
#import "DataRegisterResult.h"
#import <Mantle/Mantle.h>
#import "ServiceRegister+Services.h"
#import "CollectedDataTableViewCell.h"

@interface MainViewController ()

@end

@implementation MainViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    collectedDatas = [[NSMutableArray<DataResult *> alloc] init];
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@"Loading Data"]];
    [refreshControl addTarget:self action:@selector(requestData) forControlEvents:UIControlEventValueChanged];
    [tableViewOfDatas addSubview:refreshControl];
    
    [tableViewOfDatas setContentOffset:CGPointMake(0, -refreshControl.frame.size.height)];
    [refreshControl beginRefreshing];
    [self requestData];
}

-(void)requestData {
    //
    [collectedDatas removeAllObjects];
    [tableViewOfDatas reloadData];
    
    //Checks if the device is auto regitered
    if ([RaiseUIOT isAutoRegistered]) {
        //Checks if there is need to revalidate auto register
        [RaiseUIOT willNeedToValidateAutoRegister:^{
            //Revalidates auto register
            [RaiseUIOT revalidateAutoRegister:^(AutoRegisterResult * _Nullable autoRegisterResult) {
                //Loads all data registered
                [self requestAllData];
            } andErroHandler:^(NSError * _Nullable error) {
                
            }];
        } andNoNeedsHandler:^{
            //Loads all data registered
            [self requestAllData];
        } andErroHandler:^(NSError * _Nullable error) {
            
        }];
    //Starts the process of auto register
    } else {
        //Auto register process
        [RaiseUIOT autoRegister:^(AutoRegisterResult * _Nonnull autoRegisterResult) {
            //Loads all data registered
            [self requestAllData];
        } andErroHandler:^(NSError * _Nonnull error) {
            
        }];
    }
}

-(void)requestAllData {
    [RaiseUIOT listCollectedDataForService:SERVICE_NAME_FOR_LOCATION andSuccessHandler:^(DataRegisterResult * _Nullable dataRegisterResult) {
        //
        [self addRegistersOrdered:dataRegisterResult.datas];
        
        [tableViewOfDatas reloadData];
        [refreshControl endRefreshing];
    } andCompletionHandlerWithError:^(NSError * _Nullable error) {
        
    }];
    
    [RaiseUIOT listCollectedDataForService:SERVICE_NAME_FOR_NETWORK_SIGNAL andSuccessHandler:^(DataRegisterResult * _Nullable dataRegisterResult) {
        //
        [self addRegistersOrdered:dataRegisterResult.datas];
        
        [tableViewOfDatas reloadData];
        [refreshControl endRefreshing];
    } andCompletionHandlerWithError:^(NSError * _Nullable error) {
        
    }];
    
    [RaiseUIOT listCollectedDataForService:SERVICE_NAME_FOR_BATTERY andSuccessHandler:^(DataRegisterResult * _Nullable dataRegisterResult) {
        //
        [self addRegistersOrdered:dataRegisterResult.datas];
        
        [tableViewOfDatas reloadData];
        [refreshControl endRefreshing];
    } andCompletionHandlerWithError:^(NSError * _Nullable error) {
        
    }];
}

-(void)addRegistersOrdered:(NSArray<DataResult *> *)array {
    [collectedDatas addObjectsFromArray:array];
    [collectedDatas sortUsingComparator:^NSComparisonResult(DataResult*  _Nonnull obj1, DataResult*  _Nonnull obj2) {
        return [obj2.clientTime compare:obj1.clientTime];
    }];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return collectedDatas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DataResult *data = [collectedDatas objectAtIndex:indexPath.row];
    
    CollectedDataTableViewCell *cell = [tableViewOfDatas dequeueReusableCellWithIdentifier:@"CollectedDataCell"];
    //Sets collected date
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy hh:mm:ss"];
    [[cell lbDate] setText:[formatter stringFromDate:data.clientTime]];
    
    //Sets collected datas
    NSMutableString *values = [[NSMutableString alloc] init];
    for (id key in data.dataValues) {
        [values appendFormat:@"%@ = %@, ", key, [data.dataValues valueForKey:key]];
    }
    [[cell lbDatas] setText:[values substringWithRange:NSMakeRange(0, values.length-2)]];
    
    //Sets collected tags
    NSMutableString *tags = [[NSMutableString alloc] init];
    for (NSString* tag in data.tags) {
        [tags appendFormat:@"%@, ", tag];
    }
    [[cell lbTags] setText:[tags substringWithRange:NSMakeRange(0, tags.length-2)]];
    
    return cell;
}

#pragma mark - Navigation

- (IBAction)unwindSegue:(UIStoryboardSegue *)unwindSegue {
}

@end
