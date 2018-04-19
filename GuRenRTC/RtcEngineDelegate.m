//
//  RtcEngineDelegate.m
//  GuRenRTC
//
//  Created by Xu Zheng on 2018/4/14.
//  Copyright © 2018年 GuDian. All rights reserved.
//

#import "RtcEngineDelegate.h"

@implementation RtcEngineDelegate
- (void)dealloc{
    NSLog(@" RtcEngineDelegate is dealloc");
    _userLeaveBlock = nil;
    _userEnterBlock = nil;
}

- (void)rtcEngine:(xRTCEngineKit *)engine didOccurWarning:(int32_t)warningCode
{
    NSLog(@"didOccurWarning...%d", warningCode ) ;
}

- (void)rtcEngine:(xRTCEngineKit *)engine didOccurError:(int32_t)errorCode
{
    
}

- (void)rtcEngine:(xRTCEngineKit *)engine
reportAudioVolumeIndicationOfSpeakers:(NSArray*)speakers
      totalVolume:(int32_t)totalVolume
{
}

- (void)rtcEngine:(xRTCEngineKit *)engine
firstLocalVideoFrameWithSize:(CGSize)size elapsed:(int32_t)elapsed
{
}

- (void)rtcEngine:(xRTCEngineKit *)engine
firstRemoteVideoDecodedOfUid:(uint64_t)uid size:(CGSize)size elapsed:(uint32_t)elapsed
{
}

- (void)rtcEngine:(xRTCEngineKit *)engine
firstRemoteVideoFrameOfUid:(uint64_t)uid
             size:(CGSize)size
          elapsed:(uint32_t)elapsed
{
}

- (void)rtcEngine:(xRTCEngineKit *)engine
   didJoinedOfUid:(uint64_t)uid elapsed:(uint32_t)elapsed
{
    NSLog(@"$$$$$$$$$$$ User %lld Enter $$$$$$$$$$", uid);
    if (_userEnterBlock) {
        _userEnterBlock(uid);
    }
}

- (void)rtcEngine:(xRTCEngineKit *)engine
  didOfflineOfUid:(uint64_t)uid
           reason:(int32_t)reason
{
    if (_userLeaveBlock) {
        _userLeaveBlock(uid);
    }
}

- (void)rtcEngine:(xRTCEngineKit *)engine
    didAudioMuted:(BOOL)muted
            byUid:(uint64_t)uid
{
}

- (void)rtcEngine:(xRTCEngineKit *)engine
    didVideoMuted:(BOOL)muted
            byUid:(uint64_t)uid
{
    
}

- (void)rtcEngine:(xRTCEngineKit *)engine
  didVideoEnabled:(BOOL)enabled
            byUid:(uint64_t)uid
{
}

- (void)rtcEngine:(xRTCEngineKit *)engine
  localVideoStats:(int32_t)stats
{
}

- (void)rtcEngine:(xRTCEngineKit *)engine
 remoteVideoStats:(int32_t)stats
{
}

- (void)rtcEngineMediaEngineDidLoaded:(xRTCEngineKit *)engine
{
}

- (void)rtcEngineMediaEngineDidStartCall:(xRTCEngineKit *)engine
{
}

- (void)rtcEngineMediaEngineDidAudioMixingFinish:(xRTCEngineKit *)engine
{
}

- (void)rtcEngineCameraDidReady:(xRTCEngineKit *)engine
{
}

- (void)rtcEngineVideoDidStop:(xRTCEngineKit *)engine
{
}

- (void)rtcEngineConnectionDidInterrupted:(xRTCEngineKit *)engine
{
}

- (void)rtcEngineConnectionDidLost:(xRTCEngineKit *)engine
{
}

- (void)rtcEngine:(xRTCEngineKit *)engine
   didJoinChannel:(NSString*)channel
          withUid:(uint64_t)uid
          elapsed:(uint32_t) elapsed
{
}

- (void)rtcEngine:(xRTCEngineKit *)engine
 didRejoinChannel:(NSString*)channel
          withUid:(uint64_t)uid
          elapsed:(uint32_t) elapsed
{
}

- (void)rtcEngine:(xRTCEngineKit *)engine
   reportRtcStats:(uint32_t)stats
{
}

- (void)rtcEngine:(xRTCEngineKit *)engine
didApiCallExecute:(NSString*)api error:(int32_t)error
{
}

- (void)rtcEngine:(xRTCEngineKit *)engine
didRefreshRecordingServiceStatus:(uint32_t)status
{
}

- (void)rtcEngine:(xRTCEngineKit *)engine
receiveStreamMessageFromUid:(uint64_t)uid
         streamId:(int32_t)streamId
             data:(NSData*)data
{
}

- (void)rtcEngineRequestChannelKey:(xRTCEngineKit *)engine
{
}
@end
