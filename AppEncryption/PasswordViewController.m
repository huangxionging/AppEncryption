//
//  PasswordViewController.m
//  AppEncryption
//
//  Created by huangxiong on 15/4/15.
//  Copyright (c) 2015年 New_Life. All rights reserved.
//

#import "PasswordViewController.h"
#import "HXEncryptionView.h"
#import "CircleNodeView.h"
#import "HXLinear.h"

@interface PasswordViewController ()

@property (nonatomic, assign) CGPoint start;

@property (nonatomic, assign) CGPoint end;

@property (nonatomic, strong) NSMutableArray *linearArray;

@property (nonatomic, strong) HXEncryptionView *encryptionView;

@property (nonatomic, copy) NSMutableString *password;

@property (nonatomic, copy) NSMutableString *onceString;

@property (nonatomic, assign) BOOL isEncrypt;

@property (nonatomic, assign) NSInteger passwordCount;

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _passwordCount = 1;
    
    _isEncrypt = [[NSUserDefaults standardUserDefaults] boolForKey: ENCRYPTION_APP];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    if (_isEncrypt == YES) {
        [self setTitle: @"关闭密码"];
    }
    else {
        [self setTitle: @"设置新密码"];
    }
    
    CGFloat locationY = ([[UIScreen mainScreen] bounds].size.height - 400) / 2;
    
    _encryptionView = [[HXEncryptionView alloc] initWithFrame: CGRectMake(0, locationY, 375, 400)];
    _encryptionView.backgroundColor = [UIColor blackColor];
    [self.view addSubview: _encryptionView];
    
    // 按钮数量
    NSInteger count = 3;
    // 边界宽度
    NSInteger edgeWidth = 50;
    // 剩余最大宽度
    CGFloat maxLength = [[UIScreen mainScreen] bounds].size.width - edgeWidth;
    // 按钮占位宽度
    CGFloat width = maxLength / count;
    
    for (NSInteger index = 0; index < 9; ++index) {
        CircleNodeView  *nodeView = [[CircleNodeView alloc] initWithFrame: CGRectMake(edgeWidth + (index % count) * width, edgeWidth + (index / 3) * width, width - edgeWidth, width - edgeWidth)];
        nodeView.tag = index + 1;
        [_encryptionView addSubview: nodeView];
    }
    
    if (_linearArray == nil) {
        _linearArray = [[NSMutableArray alloc] initWithCapacity: 10];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint point = [[touches anyObject] locationInView: _encryptionView];
    
    CircleNodeView *nodeView = (CircleNodeView *)[_encryptionView hitTest:point withEvent: event];
    
    if ([nodeView class] == [CircleNodeView class] && nodeView.isSelected == NO) {
        nodeView.backgroundColor = [UIColor redColor];
        _start = nodeView.center;
        nodeView.isSelected = YES;
        HXLinear *linear = [[HXLinear alloc] initWithStart: _start AndEnd: _start];
        [_linearArray addObject: linear];
        
        NSString *string = [NSString stringWithFormat: @"%ld", (long) nodeView.tag];
        
        _password = [NSMutableString stringWithString: string];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint point = [[touches anyObject] locationInView: _encryptionView];
    
    HXLinear *linear = [_linearArray lastObject];
    linear.end = point;
    
    CircleNodeView *nodeView = (CircleNodeView *)[_encryptionView hitTest:point withEvent: event];
    
    if ([nodeView class] == [CircleNodeView class] && nodeView.isSelected == NO) {
        nodeView.backgroundColor = [UIColor redColor];
        nodeView.isSelected = YES;
        _end = nodeView.center;
        HXLinear *linear = [_linearArray lastObject];
        linear.end = _end;
        _start = _end;
        HXLinear *linearNext = [[HXLinear alloc] initWithStart: _start AndEnd: _start];
        [_linearArray addObject: linearNext];
        
        [_password appendFormat: @"%ld", (long) nodeView.tag];
    }
    _encryptionView.linearArray = _linearArray;
    [_encryptionView setNeedsDisplay];
}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    NSLog(@"%@", _password);
    
    if (_isEncrypt == NO) {
        
        if (_passwordCount == 1) {
            [self setTitle: @"再次设置密码"];
            _passwordCount++;
            _onceString = _password;
        }
        else {
            
            if ([_password isEqualToString: _onceString] == YES) {
                [[NSUserDefaults standardUserDefaults] setObject: _password forKey: PASSWORD];
                
                [[NSUserDefaults standardUserDefaults] setBool: YES forKey: ENCRYPTION_APP];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [self.navigationController popViewControllerAnimated: YES];
            }
            else {
                _encryptionView.isRed = YES;
                [_encryptionView setNeedsDisplay];
            }
        }
    }
    else {
        NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey: PASSWORD];
        
        if ([_password isEqualToString: password]) {
            
            if (self.navigationController == nil) {
                [self dismissViewControllerAnimated: YES completion:^{
                    
                }];
            }
            else {
                [[NSUserDefaults standardUserDefaults] setBool: NO forKey: ENCRYPTION_APP];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self.navigationController popViewControllerAnimated: YES];
            }
            
        }
        else {
            _encryptionView.isRed = YES;
            [_encryptionView setNeedsDisplay];
        }
    }
    
    [self performSelector: @selector(clearEncrypt) withObject: nil afterDelay: 0.5];
}



- (void) clearEncrypt {
    
    for (NSInteger index = 0; index < 9; ++index) {
        CircleNodeView  *nodeView = (CircleNodeView *)[_encryptionView viewWithTag: index + 1];
        nodeView.backgroundColor = [UIColor clearColor];
        nodeView.isSelected = NO;
    }
    
    [_linearArray removeAllObjects];
    _encryptionView.isRed = NO;
    [_encryptionView setNeedsDisplay];
}


@end
