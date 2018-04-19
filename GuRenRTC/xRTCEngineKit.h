//
//  xRTCEngineObjC.h
//  xRTCEngineCore-iOS
//
//  Created by sunhui on 2017/10/8.
//  Copyright © 2017年 sunhui. All rights reserved.
//

#ifndef __xRTCEngineObjC_H__
#define __xRTCEngineObjC_H__

#import <UIKit/UIKit.h>
#include <stdint.h>

typedef NS_ENUM(uint32_t, xRTCChannelProfile) {
    xRTC_ChannelProfile_Communication = 0,
    xRTC_ChannelProfile_LiveBroadcasting = 1,
};


typedef NS_ENUM(uint32_t, xRTCRenderMode)
{
    RENDER_TYPE_FULL = 0,       // 拉伸模式 会有变形，充满view
    RENDER_TYPE_ADAPTIVE = 1,   // 上下/左右加黑边，画面不变形
    RENDER_TYPE_CROP = 2,       // 会剪切画面，适应view
    RENDER_TYPE_AUTO = 3,       // 自动模式 如果都是w>h，则裁切模式，否则加黑边模式
};


//====
#define VIDEO_CAPTURE_TYPE_16X9         ( 0x000 )

// Image resolution
#define VIDEO_SIZE_160                  ( 1 )
#define VIDEO_SIZE_320                  ( 2 )
#define VIDEO_SIZE_480                  ( 3 )
#define VIDEO_SIZE_640                  ( 4 )
#define VIDEO_SIZE_800                  ( 5 )
#define VIDEO_SIZE_960                  ( 6 )
#define VIDEO_SIZE_1280                 ( 8 )
#define VIDEO_SIZE_1920                 ( 0xf )


#define VIDEO_CAPTURE_TYPE_16X9_160     ( VIDEO_CAPTURE_TYPE_16X9+VIDEO_SIZE_160 )   // 160*120
#define VIDEO_CAPTURE_TYPE_16X9_320     ( VIDEO_CAPTURE_TYPE_16X9+VIDEO_SIZE_320 )
#define VIDEO_CAPTURE_TYPE_16X9_480     ( VIDEO_CAPTURE_TYPE_16X9+VIDEO_SIZE_480 )
#define VIDEO_CAPTURE_TYPE_16X9_640     ( VIDEO_CAPTURE_TYPE_16X9+VIDEO_SIZE_640 )
#define VIDEO_CAPTURE_TYPE_16X9_800     ( VIDEO_CAPTURE_TYPE_16X9+VIDEO_SIZE_800 )
#define VIDEO_CAPTURE_TYPE_16X9_960     ( VIDEO_CAPTURE_TYPE_16X9+VIDEO_SIZE_960 )
#define VIDEO_CAPTURE_TYPE_16X9_1280    ( VIDEO_CAPTURE_TYPE_16X9+VIDEO_SIZE_1280 )   // 1280*720
#define VIDEO_CAPTURE_TYPE_16X9_1920    ( VIDEO_CAPTURE_TYPE_16X9+VIDEO_SIZE_1920 )


#define VIDEO_CAPTURE_TYPE_4X3          ( 0x100 )
#define VIDEO_CAPTURE_TYPE_4X3_160      ( VIDEO_CAPTURE_TYPE_4X3+VIDEO_SIZE_160 )   // 160*120
#define VIDEO_CAPTURE_TYPE_4X3_320      ( VIDEO_CAPTURE_TYPE_4X3+VIDEO_SIZE_320 )
#define VIDEO_CAPTURE_TYPE_4X3_480      ( VIDEO_CAPTURE_TYPE_4X3+VIDEO_SIZE_480 )
#define VIDEO_CAPTURE_TYPE_4X3_640      ( VIDEO_CAPTURE_TYPE_4X3+VIDEO_SIZE_640 )
#define VIDEO_CAPTURE_TYPE_4X3_800      ( VIDEO_CAPTURE_TYPE_4X3+VIDEO_SIZE_800 )
#define VIDEO_CAPTURE_TYPE_4X3_960      ( VIDEO_CAPTURE_TYPE_4X3+VIDEO_SIZE_960 )
#define VIDEO_CAPTURE_TYPE_4X3_1280     ( VIDEO_CAPTURE_TYPE_4X3+VIDEO_SIZE_1280 )   // 1280*720
#define VIDEO_CAPTURE_TYPE_4X3_1920     ( VIDEO_CAPTURE_TYPE_4X3+VIDEO_SIZE_1920 )   // 1280*720

#define VIDEO_CAPTURE_TYPE_16X16        ( 0x200 )

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
// 使用场景 开mic carmea
//
#define RTC_TYPE_BASE                 ( 0x1 )

// 网络会议  开mic carmea
#define RTC_TYPE_NETMEET              ( 0x2 )

// VR和AR  开mic carmea
#define RTC_TYPE_VR                   ( 0x3 )

// 游戏  开mic carmea
#define RTC_TYPE_GAME                 ( 0x4 )

// 直播 只播放
#define RTC_TYPE_MCHAT                ( 0x5 )

// 直播 只播放
#define RTC_TYPE_LIVE                 ( 0x6 )

// 主动打开mic和carmera才开启
//
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


__attribute__((visibility("default"))) @interface xRTCVideoCanvas : NSObject

@property (strong, nonatomic) UIView* view;
@property (assign, nonatomic) xRTCRenderMode renderMode;
@property (assign, nonatomic) uint64_t uid; 
@end


@class xRTCEngineKit;
@protocol xRTCEngineDelegate <NSObject>
@optional

- (void)rtcEngine:(xRTCEngineKit *)
    engine didOccurWarning:(int32_t)warningCode;

- (void)rtcEngine:(xRTCEngineKit *)engine
    didOccurError:(int32_t)errorCode;

- (void)rtcEngine:(xRTCEngineKit *)engine
    reportAudioVolumeIndicationOfSpeakers:(NSArray*)speakers totalVolume:(int32_t)totalVolume;

- (void)rtcEngine:(xRTCEngineKit *)engine
            firstLocalVideoFrameWithSize:(CGSize)size elapsed:(int32_t)elapsed;

- (void)rtcEngine:(xRTCEngineKit *)engine
            firstRemoteVideoDecodedOfUid:(uint64_t)uid
            size:(CGSize)size
            elapsed:(uint32_t)elapsed;

- (void)rtcEngine:(xRTCEngineKit *)engine
            firstRemoteVideoFrameOfUid:(uint64_t)uid
            size:(CGSize)size
            elapsed:(uint32_t)elapsed;

- (void)rtcEngine:(xRTCEngineKit *)engine
            didJoinedOfUid:(uint64_t)uid elapsed:(uint32_t)elapsed;

- (void)rtcEngine:(xRTCEngineKit *)engine
            didOfflineOfUid:(uint64_t)uid
           reason:(int32_t)reason;

- (void)rtcEngine:(xRTCEngineKit *)engine
            didAudioMuted:(BOOL)muted
            byUid:(uint64_t)uid;

- (void)rtcEngine:(xRTCEngineKit *)engine
            didVideoMuted:(BOOL)muted byUid:(uint64_t)uid;

- (void)rtcEngine:(xRTCEngineKit *)engine
            didVideoEnabled:(BOOL)enabled
            byUid:(uint64_t)uid;

- (void)rtcEngine:(xRTCEngineKit *)engine
            localVideoStats:(int32_t)stats;

- (void)rtcEngine:(xRTCEngineKit *)engine
            remoteVideoStats:(int32_t)stats;

- (void)rtcEngineMediaEngineDidLoaded:(xRTCEngineKit *)engine;

- (void)rtcEngineMediaEngineDidStartCall:(xRTCEngineKit *)engine;

- (void)rtcEngineMediaEngineDidAudioMixingFinish:(xRTCEngineKit *)engine;

- (void)rtcEngineCameraDidReady:(xRTCEngineKit *)engine;

- (void)rtcEngineVideoDidStop:(xRTCEngineKit *)engine;

- (void)rtcEngineConnectionDidInterrupted:(xRTCEngineKit *)engine;

- (void)rtcEngineConnectionDidLost:(xRTCEngineKit *)engine;

- (void)rtcEngine:(xRTCEngineKit *)engine
            didJoinChannel:(NSString*)channel
            withUid:(uint64_t)uid
            elapsed:(uint32_t) elapsed;

- (void)rtcEngine:(xRTCEngineKit *)engine
            didRejoinChannel:(NSString*)channel
            withUid:(uint64_t)uid
            elapsed:(uint32_t) elapsed;

- (void)rtcEngine:(xRTCEngineKit *)engine
            reportRtcStats:(uint32_t)stats;

- (void)rtcEngine:(xRTCEngineKit *)engine
            didApiCallExecute:(NSString*)api error:(int32_t)error;

- (void)rtcEngine:(xRTCEngineKit *)engine
            didRefreshRecordingServiceStatus:(uint32_t)status;

- (void)rtcEngine:(xRTCEngineKit *)engine
            receiveStreamMessageFromUid:(uint64_t)uid
            streamId:(int32_t)streamId data:(NSData*)data;

- (void)rtcEngineRequestChannelKey:(xRTCEngineKit *)engine;

@end


__attribute__((visibility("default"))) @interface xRTCEngineKit : NSObject
{
};


+ (instancetype)sharedEngineWithAppId:(NSString*)appId
                             delegate:(id<xRTCEngineDelegate>)delegate;

+ (void)destroy ;

- (int)setVideoProfile: (int)profile
                swapWidthAndHeight:(BOOL)bSwap ;

- (int)enableVideo ;

- (int)enableAudio ;

- (int)setChannelProfile:(xRTCChannelProfile)profile;

- (int)joinChannelByKey:(NSString *)channelKey
            channelName:(NSString *)channelName
                   info:(NSString *)info
                    uid:(uint64_t)uid;

- (int)setupRemoteVideo:(xRTCVideoCanvas*)remoteCanvas;

- (int)setupLocalVideo:(xRTCVideoCanvas*)localCanvas;

- (int)muteLocalVideoStream:(BOOL)bMute;

- (int)muteRemoteVideoStream:(uint64_t)uid
                        mute:(BOOL)bMute;

- (int)muteLocalAudioStream:(BOOL)bMute;


- (int)muteRemoteAudioStream:(uint64_t)uid
                        mute:(BOOL)bMute;

- (int)leaveChannel:(int)reson ;

- (int)stopPreview ;

@end



#endif /* xRTCEngineObjC_h */
