//
//  RQAlertView.h
//  DHBaseProject_RQ
//
//  Created by The good times on 2017/8/29.
//  Copyright © 2017年 dhyt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectValueBlock) (id value);
typedef void(^tapBackgroundBlock)(void);

@interface RQAlertView : UIView

+ (RQAlertView *)alertView;

@property (nonatomic, strong)   UIColor         *selectColor;

@property (nonatomic, copy)     NSString        *title;

@property (nonatomic, strong)   NSArray         *titles;

@property (nonatomic, assign)   BOOL            hiddenOfBackground;


- (void)hiddenView:(BOOL)animation;
- (void)showView:(BOOL)animation;

- (void)setSelectValueCallBack:(selectValueBlock)block;

 /**
  当hiddenOfBackground = YES, 才会回调
  */
- (void)setTapBackgroundViewCallBack:(tapBackgroundBlock)block;

@end
