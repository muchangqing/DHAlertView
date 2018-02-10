//
//  UIView+Nib.m
//  DHBaseProject_ZJ
//
//  Created by 我的大好时光 on 2017/4/1.
//  Copyright © 2017年 dhyt. All rights reserved.
//

#import "UIView+Nib.h"

@implementation UIView (Nib)
#pragma mark - Nibs
+ (UINib *)dh_loadNib
{
        return [self dh_loadNibNamed:NSStringFromClass([self class])];
}
+ (UINib *)dh_loadNibNamed:(NSString*)nibName
{
        return [self dh_loadNibNamed:nibName bundle:[NSBundle mainBundle]];
}
+ (UINib *)dh_loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle
{
        return [UINib nibWithNibName:nibName bundle:bundle];
}
+ (instancetype)dh_loadInstanceFromNib
{
        return [self dh_loadInstanceFromNibWithName:NSStringFromClass([self class])];
}
+ (instancetype)dh_loadInstanceFromNibWithName:(NSString *)nibName
{
        return [self dh_loadInstanceFromNibWithName:nibName owner:nil];
}
+ (instancetype)dh_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner
{
        return [self dh_loadInstanceFromNibWithName:nibName owner:owner bundle:[NSBundle mainBundle]];
}
+ (instancetype)dh_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle
{
        UIView *result = nil;
        NSArray* elements = [bundle loadNibNamed:nibName owner:owner options:nil];
        for (id object in elements)
        {
                if ([object isKindOfClass:[self class]])
                {
                        result = object;
                        break;
                }
        }
        return result;
}
@end
