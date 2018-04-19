//
//  SettingsViewController.h
//  GuRenRTC
//
//  Created by Xu Zheng on 2018/4/13.
//  Copyright © 2018年 GuDian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingsViewController;
@protocol SettingsViewControllerDelegate <NSObject>

- (void)didCloseSettingVC:(SettingsViewController*)settingVC;

@end


@class xRTCEngineKit;
@interface SettingsViewController : UIViewController
@property (nonatomic, weak) id<SettingsViewControllerDelegate> delegate;

@property (nonatomic, weak) xRTCEngineKit *engine;

@property (nonatomic) int profile;

@end
