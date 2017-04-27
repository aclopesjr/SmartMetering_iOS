//
//  CollectedDataTableViewCell.h
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/23/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectedDataTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lbDate;
@property (strong, nonatomic) IBOutlet UILabel *lbDatas;
@property (strong, nonatomic) IBOutlet UILabel *lbTags;


@end
