//
//  UIView+Nib.h
//  DHBaseProject_ZJ
//
//  Created by 我的大好时光 on 2017/4/1.
//  Copyright © 2017年 dhyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Nib)
+ (UINib *)dh_loadNib;
+ (UINib *)dh_loadNibNamed:(NSString*)nibName;
+ (UINib *)dh_loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle;

+ (instancetype)dh_loadInstanceFromNib;
+ (instancetype)dh_loadInstanceFromNibWithName:(NSString *)nibName;
+ (instancetype)dh_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner;
+ (instancetype)dh_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle;
@end
