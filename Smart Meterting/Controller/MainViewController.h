//
//  MainViewController.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/11/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataResult.h"

@interface MainViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *tableViewOfDatas;
    UIRefreshControl *refreshControl;
    NSMutableArray<DataResult *> *collectedDatas;
}

@end
