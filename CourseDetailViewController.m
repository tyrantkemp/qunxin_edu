//
//  CourseDetailViewController.m
//  qunxin_edu
//
//  Created by 肖准 on 6/22/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "CourseDetailViewController.h"
#import "SwipableViewController.h"
#import "CatologTableViewController.h"
#import "InfoViewController.h"
#import "ReferenceTableViewController.h"
#import "MBProgressHUD.h"

#import "courseMJ.h"
@interface CourseDetailViewController()
{
    NSURL* _videoUrl;
    NSMutableArray* _courseArr;
   
    CatologTableViewController* _cata1;
    
    InfoViewController* _info;
    
    ReferenceTableViewController* _refer;
    SwipableViewController* _swapctl;
    
    
}
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation CourseDetailViewController

-(void)viewDidLoad{
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initVideo];

    [self initsubviews];

    [self settoolbarOperations];
    
    
    //异步操作放在最后
    [self getcourseData];

    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}
#pragma mark - 视频初始化
-(void)initVideo{
    _videoUrl =[NSURL URLWithString:@"http://krtv.qiniudn.com/150522nextapp"];
    MRVLCPlayer *player = [[MRVLCPlayer alloc] init];
    
    UIView* statusbackview = [UIView new];
    [statusbackview setFrame:CGRectMake(0, 0, screenheight, 20)];
    [statusbackview setBackgroundColor:[UIColor colorWithRed:0.059 green:0.067 blue:0.071 alpha:1.000]];
    [self.view addSubview:statusbackview];
    [player setFrame:CGRectMake(0, 20, screenwith, screenheight/3)];
    player.mediaURL = _videoUrl;
    player.isAutoPlay =NO;
    [player showInView:self.view];
    player.closed = ^(void){
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    __weak MRVLCPlayer* weakplayer = player;
    player.screenchange=^(void){
        if(weakplayer.isFullscreenModel){
            _swapctl.view.hidden=YES;
            _toolbar.hidden = YES;
        }else {
            _swapctl.view.hidden=NO;
            _toolbar.hidden = NO;
        }
        
    };
    

}

-(void)initsubviews{
    
    _cata1 = [[CatologTableViewController alloc]initWithCourseArr:_courseArr];
    _info = [InfoViewController new];
    _refer= [ReferenceTableViewController new];
    
    
    
    _swapctl= [[SwipableViewController alloc]initWithTitle:@"课程" andSubTitles:@[@"目录",@"简介",@"相关"] andControllers:@[_cata1,_info,_refer] underTabbar:YES];
    
    [_swapctl.view setFrame:CGRectMake(0, screenheight/3+20, screenwith, screenheight/3*2-20)];
    
    //最右端设置为不能滑动 方便cell滑动操作
    __weak typeof(SwipableViewController) *weakswip = _swapctl;
    _swapctl.viewPager.viewDidAppear = ^(NSInteger index){
        if(index == 2){
            weakswip.viewPager.tableView.scrollEnabled = NO;
        }else {
            weakswip.viewPager.tableView.scrollEnabled = YES;
    
        }
    };
    [self.view addSubview:_swapctl.view];
    [self addChildViewController:_swapctl];
    
    
    _toolbar = [[courseToolBar alloc]initWithFrame:CGRectMake(0, screenheight-44, screenwith, 40)];
    
    [self.view addSubview:_toolbar];

    
    
    
}

#pragma mark - 工具栏操作
-(void)settoolbarOperations{
    __weak CourseDetailViewController *weakself =self;
    _toolbar.starPressed = ^(void){
        weakself.toolbar.isStared = !weakself.toolbar.isStared;
    };
}

-(UIButton*)playBtn{
    if(!_playBtn){
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_playBtn setImage:[UIImage imageNamed:@"start_play"] forState:UIControlStateNormal];
        [_playBtn setBounds:CGRectMake(0, 0, 50, 50)];
        [_playBtn bk_addEventHandler:^(id sender) {
            self.videoController.contentURL = _videoUrl;
            _playBtn.hidden = YES;
            
        } forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _playBtn;
}


-(void)playvideo:(NSURL*) url{
    
    if(!self.videoController){
        self.videoController = [[ KRVideoPlayerController alloc]initWithFrame:CGRectMake(0, 0, screenwith, screenheight/5*2)];
        [self.videoController.view addSubview:self.playBtn];
        [self.playBtn zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
    
            layout.topSpace(screenheight/5-25).leftSpace(screenwith/2-25);
            
        }];
        __weak typeof(self) weakself = self;
        [self.videoController setDimissCompleteBlock:^{
            weakself.videoController = nil;
            [weakself.navigationController popViewControllerAnimated:YES];
        }];
        
       [self.videoController showInWindow];
    }
    
   // self.videoController.contentURL = url;
    //[self.videoController stop];

    
}



-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


#pragma mark - 获取课程信息
-(void)getcourseData{
    _hud = [Utils createHUDWithText:@"正在加载" ];
    
    
    [[XZHttp sharedInstance]getWithURLString:[NSString stringWithFormat:@"%@%@%@?id=%d",MAIN,COURSE,GETSECTIONINFO,self.sectionId] parameters:nil success:^(id responseObject) {
  
        
        NSDictionary *json = [Utils getJsonStringFromResponseObj:responseObject];

        NSLog(@"response str:%@",json);
        NSInteger isSuccess = [(NSString*)json[@"isSuccess"] intValue];
        NSString* msg = (NSString*)json[@"message"];
        if(isSuccess != 1){
            
            
            dispatch_after (dispatch_time (DISPATCH_TIME_NOW, (int64_t )(.5 * NSEC_PER_SEC )), dispatch_get_main_queue (), ^{
                [self.navigationController popViewControllerAnimated:YES];
                _hud.mode = MBProgressHUDModeCustomView;
                _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
                _hud.labelText = msg;
                [_hud hide:YES afterDelay:1];

            });
        }else {
        
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_hud hide:YES];
                
                
                if(!_courseArr){
                    _courseArr = [NSMutableArray new];
                }else {
                    [_courseArr removeAllObjects];
                }
                
                NSArray* arr = (NSArray*)json[@"data"];

                _courseArr = [courseMJ mj_objectArrayWithKeyValuesArray:arr];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    _cata1.courseArr = _courseArr;
                    [_cata1.tableView reloadData];
                    
                    
                });
          

                
            });
            
            
        }
        
        
        
        
    } failure:^(NSError *error) {
        //[_hud hide:YES];
      //  _maskview.hidden = YES;
        [self.navigationController popViewControllerAnimated:YES];
        _hud.mode = MBProgressHUDModeCustomView;
        _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
        // _hud.labelText = [@(operation.response.statusCode) stringValue];
        // _hud.detailsLabelText = error.userInfo[NSLocalizedDescriptionKey];
        _hud.labelText = error.userInfo[NSLocalizedDescriptionKey];
        
        [_hud hide:YES afterDelay:5];
        
        
    }];
    
    
}




@end
