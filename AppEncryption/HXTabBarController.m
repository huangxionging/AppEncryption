//
//  HXTabBarController.m
//  AppEncryption
//
//  Created by huangxiong on 15/7/16.
//  Copyright (c) 2015年 New_Life. All rights reserved.
//

#import "HXTabBarController.h"
#import "PasswordViewController.h"

@interface HXTabBarController ()

@property (nonatomic, assign) BOOL isPass;

@end

@implementation HXTabBarController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    BOOL value = [[NSUserDefaults standardUserDefaults] boolForKey: ENCRYPTION_APP];
    if (value == YES && _isPass == NO) {
        NSLog(@"需要密码");
        [[NSNotificationCenter defaultCenter] postNotificationName: NOTIFICATION_ENTER_APP object: nil];
        _isPass = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(enterApp) name: NOTIFICATION_ENTER_APP object: nil];
    _isPass = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) enterApp {
    PasswordViewController *passwordViewController = [[PasswordViewController alloc] init];
    
    [self presentViewController: passwordViewController animated: YES completion:^{
        
    }];
}

@end
