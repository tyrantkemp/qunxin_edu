//
//  CourseDetailViewController.h
//  qunxin_edu
//
//  Created by 肖准 on 6/22/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KRVideoPlayerController.h"
#import "MRVLCPlayer.h"
#import "courseToolBar.h"

@interface CourseDetailViewController : UIViewController
@property(nonatomic,strong)KRVideoPlayerController* videoController;

@property(nonatomic,strong)NSString* url;

@property(nonatomic,assign)NSInteger sectionId;
@property(nonatomic,strong)courseToolBar* toolbar;
@property(nonatomic,strong)UIButton* playBtn;
@end
