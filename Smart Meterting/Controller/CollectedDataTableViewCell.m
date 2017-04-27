//
//  CollectedDataTableViewCell.m
//  Smart Meterting
//
//  Created by Antonio Lopes on 4/23/17.
//  Copyright © 2017 Antonio Lopes. All rights reserved.
//

#import "CollectedDataTableViewCell.h"

@implementation CollectedDataTableViewCell

@synthesize lbDate, lbDatas, lbTags;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
