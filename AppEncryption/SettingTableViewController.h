//
//  SettingTableViewController.h
//  AppEncryption
//
//  Created by huangxiong on 15/4/15.
//  Copyright (c) 2015年 New_Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISwitch *encryptionSwitch;

//- (IBAction)encryptApp:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UISwitch *changePasswordSwitch;

- (IBAction)changePassword:(UISwitch *)sender;

@end
