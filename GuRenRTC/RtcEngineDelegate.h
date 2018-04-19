//
//  RtcEngineDelegate.h
//  GuRenRTC
//
//  Created by Xu Zheng on 2018/4/14.
//  Copyright © 2018年 GuDian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "xRTCEngineKit.h"

typedef void(^UserEventBlock)(uint64_t uid);

@interface RtcEngineDelegate : NSObject <xRTCEngineDelegate>
@property (nonatomic,copy) UserEventBlock userEnterBlock;
@property (nonatomic,copy) UserEventBlock userLeaveBlock;
@end
