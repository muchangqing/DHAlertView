//
//  RQAlertView.h
//  DHBaseProject_RQ
//
//  Created by The good times on 2017/8/29.
//  Copyright © 2017年 dhyt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectValueBlock) (id value);

@interface RQAlertView : UIView

+ (RQAlertView *)showAlertView;

@property (nonatomic, copy)     NSString        *title;

@property (nonatomic, strong)   NSArray         *titles;

- (void)hiddenView:(BOOL)animation;

- (void)setSelectValueCallBack:(selectValueBlock)block;


@end
