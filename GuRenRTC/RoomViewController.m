//
//  RoomViewController.m
//  GuRenRTC
//
//  Created by Xu Zheng on 2018/4/13.
//  Copyright © 2018年 GuDian. All rights reserved.
//

#import "RoomViewController.h"
#import "xRTCEngineKit.h"

@interface RoomViewController (){
    NSMutableArray *_multiViewArray;
    uint64_t _userId;
    
    xRTCVideoCanvas *_myCanvas;
    NSMutableDictionary *       _canvasMap ;
    
    BOOL _videoMuted;
    BOOL _audioMuted;
}


@property (nonatomic, weak) IBOutlet UIView *oneVoneRemoteView;
@property (nonatomic, weak) IBOutlet UIView *oneVoneLocalView;

@property (nonatomic, weak) IBOutlet UIButton *leaveRoomButton;
@property (nonatomic, weak) IBOutlet UIButton *muteVideoButton;
@property (nonatomic, weak) IBOutlet UIButton *muteAudioButton;

- (IBAction)leaveRoomButtonTapped:(id)sender;
- (IBAction)muteVideoButtonTapped:(id)sender;
- (IBAction)muteAudioButtonTapped:(id)sender;
@end

@implementation RoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *myView;
    if (_type == RtcViewTypeMulti) {
        _multiViewArray = [NSMutableArray arrayWithCapacity:0];
        
        CGRect bounds = self.view.bounds;
        CGFloat width = CGRectGetWidth(bounds) / 3;
        CGFloat height = width * 16.0 / 9.0;
        CGRect frame;
        for (int i = 0,k = 0; i < 6; i++,k++) {
            if (i == 3) {
                k = 0;
            }
            frame = CGRectMake(k * width, 20 + ((int)(i/3))*height + (i < 3 ? 20 : 40 ), width, height);
            UIView *view = [[UIView alloc]initWithFrame:frame];
            [self.view addSubview:view];
            view.tag = 0;
            [_multiViewArray addObject:view];
            if (i == 0) {
                myView = view;
                view.tag = 1;
            }
        }
    }else{
        _oneVoneLocalView.tag = 0;
        _oneVoneRemoteView.tag = 0;
        myView = _oneVoneLocalView;
    }
    
    _userId = arc4random() ;
    _myCanvas = [[xRTCVideoCanvas alloc]init] ;
    _myCanvas.uid = _userId ;
    _myCanvas.renderMode = RENDER_TYPE_ADAPTIVE ;
    _myCanvas.view = myView ;
    _canvasMap = [NSMutableDictionary dictionaryWithCapacity:0];
    
    //[self startEngine];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc{
    NSLog(@"@@@ RoomVC dealloc @@@");
}

- (void)startEngine{
    [_engine enableAudio] ;
    [_engine enableVideo] ;
    
    [_engine joinChannelByKey:NULL channelName:_roomId info:NULL uid:_userId] ;
    [_engine setupLocalVideo:_myCanvas] ;
    
    _videoMuted = NO;
    _audioMuted = NO;
}

- (void)userEnter:(uint64_t)userid{
    UIView * pUview = nil;
    if (_type == RtcViewTypeOneVOne) {
        if (_oneVoneRemoteView.tag == 1) {
            NSLog(@"一对一视频，已经在连麦中");
            return;
        }else{
            pUview = _oneVoneRemoteView;
        }
    }else{
        for(UIView * view in _multiViewArray)
        {
            if ( view != nil && view.tag == 0 )
            {
                pUview = view ;
                NSLog(@"Select View: %@", view);
                break ;
            }
        }
    }
    if ( pUview == nil )
    {
        NSLog(@"add user: %llu fail...", userid )  ;
        
        return ;
    }
    
    xRTCVideoCanvas *  userCanvas = [[xRTCVideoCanvas alloc]init] ;
    userCanvas.uid = userid ;
    userCanvas.renderMode = RENDER_TYPE_AUTO ;
    userCanvas.view = pUview ;
    
    pUview.tag = 1 ;
    
    NSString * strUserID = [NSString stringWithFormat:@"%llu",userid] ;
    
    [_canvasMap setObject:userCanvas forKey:strUserID] ;
    [_engine setupRemoteVideo:userCanvas] ;
    NSLog(@"add user: %llu succ...", userid )  ;
}

- (void)userLeave:(uint64_t)userid{
    NSString * strUserID = [NSString stringWithFormat:@"%llu",userid] ;
    
    xRTCVideoCanvas * canvas = [_canvasMap objectForKey:strUserID] ;
    if ( canvas == nil )
    {
        NSLog(@"remove user: %llu fail...", userid )  ;
        return ;
    }
    
    UIView * pUview = canvas.view ;
    [_canvasMap removeObjectForKey:strUserID ] ;
    pUview.tag = 0 ;
    canvas = nil ;
    NSLog(@"remove user: %llu", userid )  ;
}

- (IBAction)leaveRoomButtonTapped:(id)sender{

    __weak typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(didCloseRoomVC:)]) {
            [weakSelf.delegate didCloseRoomVC:weakSelf];
        }
    }];
}

- (IBAction)muteVideoButtonTapped:(id)sender{
    if (_engine) {
        [_engine muteLocalVideoStream:!_videoMuted];
        _videoMuted = !_videoMuted;
        [_muteVideoButton setTitle:_videoMuted ? @"打开视频" : @"关闭视频" forState:UIControlStateNormal];
    }
}

- (IBAction)muteAudioButtonTapped:(id)sender{
    if (_engine) {
        [_engine muteLocalAudioStream:!_audioMuted];
        _audioMuted = !_audioMuted;
        [_muteAudioButton setTitle:_audioMuted ? @"打开音频" : @"关闭音频" forState:UIControlStateNormal];
    }
}



@end
