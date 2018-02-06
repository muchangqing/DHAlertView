//
//  RQAlertCell.m
//  DHBaseProject_RQ
//
//  Created by The good times on 2017/8/30.
//  Copyright © 2017年 dhyt. All rights reserved.
//

#import "RQAlertCell.h"

@interface RQAlertCell()

@property (nonatomic, strong) UIView *selBgView;

@end

@implementation RQAlertCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIView *view = [UIView new];
    self.selBgView = view;
    
    self.selectedBackgroundView = self.selBgView;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setSelectedBackgroundViewColor:(UIColor *)selectedBackgroundViewColor
{
    self.selBgView.backgroundColor = selectedBackgroundViewColor;
}

@end
