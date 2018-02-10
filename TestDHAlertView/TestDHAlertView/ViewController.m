//
//  ViewController.m
//  TestDHAlertView
//
//  Created by The good times on 2018/2/10.
//  Copyright © 2018年 The good times. All rights reserved.
//

#import "ViewController.h"
#import "RQAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}

- (void)viewDidAppear:(BOOL)animated
{
    
    RQAlertView *alertView = [RQAlertView alertView];
    alertView.title  = @"test";
    alertView.titles = @[@"a", @"b", @"c" ,@"d"];
    [alertView showView:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
