//
//  ViewController.m
//  GuRenRTC
//
//  Created by Xu Zheng on 2018/4/13.
//  Copyright © 2018年 GuDian. All rights reserved.
//

#import "ViewController.h"
#import "xRTCEngineKit.h"
#import "SettingsViewController.h"
#import "RoomViewController.h"
#import "RtcEngineDelegate.h"

@interface ViewController () <SettingsViewControllerDelegate, RoomViewControllerDelegate>
{
    RtcEngineDelegate *_engineDelegate;
    int _profile;
}

@property (nonatomic, weak) IBOutlet UITextField *roomIdTextField;
@property (nonatomic, weak) IBOutlet UIButton *login1v1VideoButton;
@property (nonatomic, weak) IBOutlet UIButton *loginMultiVideoButton;
@property (nonatomic, weak) IBOutlet UIButton *settingButton;

@property (nonatomic, strong) xRTCEngineKit *engine;
@property (nonatomic, strong) RoomViewController *roomVC;

- (IBAction)loginButtonTapped:(id)sender;
- (IBAction)settingButtonTapped:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _profile = VIDEO_CAPTURE_TYPE_16X9_480;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundTapped:)];
    [self.view addGestureRecognizer:recognizer];
}

- (void)backgroundTapped:(UITapGestureRecognizer*)gestureRecognizer{
    [self closeKeyboard];
}

- (void)closeKeyboard{
    [_roomIdTextField resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadEngine{
    if (_engineDelegate == nil) {
        _engineDelegate = [[RtcEngineDelegate alloc]init];
        __weak typeof(self) weakSelf = self;
        _engineDelegate.userEnterBlock = ^(uint64_t uid){
            if (weakSelf.roomVC) {
                [weakSelf.roomVC userEnter:uid];
            }
        };
        _engineDelegate.userLeaveBlock = ^(uint64_t uid){
            if (weakSelf.roomVC) {
                [weakSelf.roomVC userLeave:uid];
            }
        };
    }
    if (_engine == nil) {
        _engine = [ xRTCEngineKit sharedEngineWithAppId:@"ios_test" delegate:_engineDelegate] ;
        [_engine setChannelProfile:xRTC_ChannelProfile_Communication] ;
        [_engine setVideoProfile:_profile swapWidthAndHeight:NO] ;
    }
}

- (IBAction)loginButtonTapped:(id)sender{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    RoomViewController *roomVC;
    if (sender == _login1v1VideoButton) {
        roomVC = [storyBoard instantiateViewControllerWithIdentifier:@"roomVC1"];
        roomVC.type = RtcViewTypeOneVOne;
    }else{
        roomVC = [storyBoard instantiateViewControllerWithIdentifier:@"roomVC2"];
        roomVC.type = RtcViewTypeMulti;
    }
    roomVC.engine = self.engine;
    roomVC.roomId = _roomIdTextField.text;
    _roomVC = roomVC;
    _roomVC.delegate = self;
    [self presentViewController:roomVC animated:YES completion:^{
        [roomVC startEngine];
    }];
}

- (IBAction)settingButtonTapped:(id)sender{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    SettingsViewController *settingsVC = [storyBoard instantiateViewControllerWithIdentifier:@"settingVC"];
    settingsVC.delegate = self;
    settingsVC.engine = self.engine;
    settingsVC.profile = _profile;
    [self presentViewController:settingsVC animated:YES completion:nil];
}


- (void)leaveEngine{
    if (_engine) {
        [_engine leaveChannel:0];
        [xRTCEngineKit destroy];
        _engineDelegate = nil;
        _engine = nil;
    }
}

- (xRTCEngineKit*)engine{
    if (_engine == nil) {
        [self loadEngine];
    }
    return _engine;
}

#pragma mark - Delegate -

- (void)didCloseRoomVC:(RoomViewController *)roomVC{
    if (_roomVC == roomVC) {
        [self leaveEngine];
        _roomVC = nil;
    }
}

- (void)didCloseSettingVC:(SettingsViewController *)settingVC{
    _profile = settingVC.profile;
}

@end
