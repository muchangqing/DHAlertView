//
//  RQAlertView.m
//  DHBaseProject_RQ
//
//  Created by The good times on 2017/8/29.
//  Copyright © 2017年 dhyt. All rights reserved.
//

#import "RQAlertView.h"
#import "RQAlertCell.h"
#import "UIViewExt.h"
#import "UIView+Nib.h"
#import "NSObject+Reflection.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

#define ITEM_HEIGHT     (50.0)
#define TITLE_HEIGHT    (50.0)

// 颜色红定义
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface RQAlertView () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView       *tableView;

@property (nonatomic, strong) UILabel           *titleLabel;

@property (nonatomic, strong) UIView            *alertView;

@property (nonatomic, strong) UIView            *lineView;

@property (nonatomic, copy)   selectValueBlock  selectBlock;

@end

@implementation RQAlertView

+ (RQAlertView *)showAlertView
{
        RQAlertView *bgView = [[RQAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        return bgView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
        self = [super initWithFrame:frame];
        if (self)
        {
                [self showView:YES];
                [self initTap];
                [self initializeViews];
        }
        return self;
}

- (void)initTap
{
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
}

- (void)initializeViews
{
        [self addSubview:self.alertView];
        
        [self.alertView addSubview:self.titleLabel];
        [self.alertView addSubview:self.lineView];
        [self.alertView addSubview:self.tableView];
}

- (void)showView:(BOOL)animation
{
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        self.alertView.alpha = 0.0;
        
        [UIView animateWithDuration:0.3 animations:^{
                
                self.alertView.alpha = 1;
        }];
}

- (void)hiddenView:(BOOL)animation
{
        self.alpha = 1.0;

        [UIView animateWithDuration:0.2 animations:^{
                self.alpha = 0.0;
                
        } completion:^(BOOL finished) {
                
                [self removeFromSuperview];
        }];
}

- (void)layoutSubviews
{
        [super layoutSubviews];
        
        NSInteger count         = self.titles.count;
        
        CGFloat leftGap         = 50.0;
        CGFloat alertHeight     = count * ITEM_HEIGHT + TITLE_HEIGHT;
        
        //alert
        CGRect alertFrame       = self.alertView.frame;
        alertFrame.size.width   = self.width_ext - leftGap * 2;
        alertFrame.size.height  = alertHeight;
        alertFrame.origin.x     = leftGap;
        alertFrame.origin.y     = (self.height_ext - alertHeight) * 0.5;
        self.alertView.frame    = alertFrame;
        
        //标题
        CGRect titleFrame       = self.titleLabel.frame;
        titleFrame.size.width   = alertFrame.size.width;
        titleFrame.size.height  = TITLE_HEIGHT;
        self.titleLabel.frame   = titleFrame;
        
        CGRect lineFrame        = self.lineView.frame;
        lineFrame.size.width    = alertFrame.size.width;
        lineFrame.size.height   = 1.0;
        lineFrame.origin.x      = 0;
        lineFrame.origin.y      = CGRectGetMaxY(titleFrame);
        self.lineView.frame     = lineFrame;
        
        //tableView
        CGRect tableFrame       = self.tableView.frame;
        tableFrame.size.width   = alertFrame.size.width;
        tableFrame.size.height  = count * ITEM_HEIGHT;
        tableFrame.origin.x     = 0;
        tableFrame.origin.y     = CGRectGetMaxY(lineFrame);
        self.tableView.frame    = tableFrame;
}

- (BOOL)isLastIndex:(NSInteger)index
{
        BOOL last = NO;
        if (index == self.titles.count - 1)
        {
                last = YES;
        }
        return last;
}

#pragma mark - action
- (void)clickTap
{
        [self hiddenView:YES];
}

#pragma mark - setter
- (void)setSelectValueCallBack:(selectValueBlock)block
{
        self.selectBlock = block;
}

- (void)setTitles:(NSArray *)titles
{
        if (_titles != titles)
        {
                _titles = titles;
        }
        [self setNeedsLayout];
        [self.tableView reloadData];
}

- (void)setTitle:(NSString *)title
{
        self.titleLabel.text = [NSString stringWithFormat:@"选择%@", title];
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
        if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"])
        {
                return NO;
        }
        return YES;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        RQAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:[RQAlertCell dh_className] forIndexPath:indexPath];
        
        cell.titleLabel.text    = self.titles[indexPath.row];
        cell.lineView.hidden    = [self isLastIndex:indexPath.row];
        
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (self.selectBlock)
        {
                self.selectBlock(self.titles[indexPath.row]);
        }
        [self hiddenView:YES];
}

#pragma mark - lazy method
- (UILabel *)titleLabel
{
        if (!_titleLabel)
        {
                _titleLabel                     = [[UILabel alloc] init];
                _titleLabel.font                = [UIFont systemFontOfSize:16];
                _titleLabel.textColor           = [UIColor blackColor];
                _titleLabel.textAlignment       = NSTextAlignmentCenter;
                _titleLabel.numberOfLines       = 1;
        }
        return _titleLabel;
}

- (UIView *)alertView
{
        if (!_alertView)
        {
                _alertView = [[UIView alloc] init];
                _alertView.userInteractionEnabled       = YES;
                _alertView.backgroundColor              = [UIColor whiteColor];
                _alertView.layer.cornerRadius           = 5.0;
                _alertView.layer.masksToBounds          = YES;
        }
        return _alertView;
}

- (UIView *)lineView
{
        if (!_lineView)
        {
                _lineView = [[UIView alloc] init];
                _lineView.backgroundColor = kUIColorFromRGB(0xe1e1e1);
        }
        return _lineView;
}

- (UITableView *)tableView
{
        if (!_tableView)
        {
                _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
                _tableView.delegate     = self;
                _tableView.dataSource   = self;
                _tableView.separatorStyle = UITableViewCellSeparatorStyleNone
                ;
                
                _tableView.rowHeight    = ITEM_HEIGHT;
                
                [_tableView registerNib:[RQAlertCell dh_loadNib] forCellReuseIdentifier:[RQAlertCell dh_className]];
        }
        return _tableView;
}

@end
