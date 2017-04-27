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
    
    //[tableViewOfDatas setDelegate:self];
    //[tableViewOfDatas setDataSource:self];
    //[tableViewOfDatas registerClass:CollectedDataTableViewCell.class forCellReuseIdentifier:@"CollectedDataCell"];
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(requestData) forControlEvents:UIControlEventValueChanged];
    [tableViewOfDatas addSubview:refreshControl];
}

-(void)requestData {
    //
    [collectedDatas removeAllObjects];
    [tableViewOfDatas reloadData];
    
    [RaiseUIOT listCollectedDataForService:SERVICE_NAME_FOR_LOCATION andSuccessHandler:^(DataRegisterResult * _Nullable dataRegisterResult) {
        //
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [collectedDatas addObjectsFromArray:dataRegisterResult.datas];
            [tableViewOfDatas reloadData];
            [refreshControl endRefreshing];
        });
    } andCompletionHandlerWithError:^(NSError * _Nullable error) {
        
    }];
    
    [RaiseUIOT listCollectedDataForService:SERVICE_NAME_FOR_NETWORK_SIGNAL andSuccessHandler:^(DataRegisterResult * _Nullable dataRegisterResult) {
        //
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [collectedDatas addObjectsFromArray:dataRegisterResult.datas];
            [tableViewOfDatas reloadData];
            [refreshControl endRefreshing];
        });
    } andCompletionHandlerWithError:^(NSError * _Nullable error) {
        
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
