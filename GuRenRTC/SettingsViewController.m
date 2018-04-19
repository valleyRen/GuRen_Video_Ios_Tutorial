//
//  SettingsViewController.m
//  GuRenRTC
//
//  Created by Xu Zheng on 2018/4/13.
//  Copyright © 2018年 GuDian. All rights reserved.
//

#import "SettingsViewController.h"
#import "xRTCEngineKit.h"

@interface SettingsViewController ()<UITableViewDelegate, UITableViewDataSource>{

}
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *doneButton;
@property (nonatomic, weak) IBOutlet UIButton *cancelButton;

- (IBAction)buttonTapped:(id)sender;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.allowsMultipleSelection = NO;
    [_tableView reloadData];
}

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    NSIndexPath *index = [NSIndexPath indexPathForRow:_engine.videoPreset inSection:0];
//    [_tableView selectRowAtIndexPath:index animated:NO scrollPosition:UITableViewScrollPositionNone];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - UITableViewDelegate


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    NSString *text;
    if (indexPath.row == 0) {
        text = @"90 x 160";
    }else if (indexPath.row == 1){
        text = @"180 x 320";
    }else if (indexPath.row == 2){
        text = @"270 x 480";
    }else if (indexPath.row == 3){
        text = @"360 x 640";
    }else if (indexPath.row == 4){
        text = @"450 x 800";
    }else if (indexPath.row == 5){
        text = @"540 x 960";
    }else if (indexPath.row == 6){
        text = @"720 x 1280";
    }
    
    int profileArray[8] = {VIDEO_CAPTURE_TYPE_16X9_160,
        VIDEO_CAPTURE_TYPE_16X9_320,
        VIDEO_CAPTURE_TYPE_16X9_480,
        VIDEO_CAPTURE_TYPE_16X9_640,
        VIDEO_CAPTURE_TYPE_16X9_800,
        VIDEO_CAPTURE_TYPE_16X9_960,
        VIDEO_CAPTURE_TYPE_16X9_1280,
        VIDEO_CAPTURE_TYPE_16X9_1920
    };
    cell.selected = (profileArray[indexPath.row] == _profile);
    if (cell.selected) {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    cell.textLabel.text = text;    
    return cell;
}

- (IBAction)buttonTapped:(id)sender{
    if (sender == _doneButton) {
        NSIndexPath *index = _tableView.indexPathForSelectedRow;
        int profile = VIDEO_CAPTURE_TYPE_16X9 + VIDEO_SIZE_160;
        if (index.row == 6) {
            profile = VIDEO_CAPTURE_TYPE_16X9 + VIDEO_SIZE_1280;
        }else{
            profile = (int)(VIDEO_CAPTURE_TYPE_16X9 + index.row + 1);
        }
        [_engine setVideoProfile:profile swapWidthAndHeight:NO];
        _profile = profile;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(didCloseSettingVC:)]) {
        [_delegate didCloseSettingVC:self];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
