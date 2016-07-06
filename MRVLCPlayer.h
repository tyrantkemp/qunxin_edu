//
//  MRVLCPlayer.h
//  MRVLCPlayer
//
//  Created by apple on 16/3/5.
//  Copyright © 2016年 Alloc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileVLCKit/MobileVLCKit.h>
#import "MRVideoControlView.h"

@interface MRVLCPlayer : UIView <VLCMediaPlayerDelegate,MRVideoControlViewDelegate>

@property (nonatomic,strong,nonnull) NSURL *mediaURL;
@property (nonatomic,assign) BOOL isFullscreenModel;
@property(nonatomic,copy) void (^closed)();

@property(nonatomic,copy) void (^screenchange)();   //点击屏幕横屏竖屏变化


@property(nonatomic,assign)Boolean isAutoPlay;
- (void)showInView:(UIView * _Nonnull)view;

@end


