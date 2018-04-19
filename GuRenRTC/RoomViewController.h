//
//  RoomViewController.h
//  GuRenRTC
//
//  Created by Xu Zheng on 2018/4/13.
//  Copyright © 2018年 GuDian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RtcViewType)
{
    RtcViewTypeOneVOne,
    RtcViewTypeMulti,
};
@class RoomViewController;
@protocol RoomViewControllerDelegate <NSObject>

- (void)didCloseRoomVC:(RoomViewController*)roomVC;

@end


@class xRTCEngineKit;
@interface RoomViewController : UIViewController

@property (nonatomic, weak) id <RoomViewControllerDelegate> delegate;

@property (nonatomic, assign) RtcViewType type;

@property (nonatomic, weak) xRTCEngineKit *engine;

@property (nonatomic, copy) NSString *roomId;

- (void)userEnter:(uint64_t)userid ;

- (void)userLeave:(uint64_t)userid ;

- (void)startEngine;
@end
