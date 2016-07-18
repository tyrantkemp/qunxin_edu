//
//  MainContentBarController.m
//  qunxin_edu
//
//  Created by 肖准 on 6/5/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "MainContentBarController.h"
#import "CorporationTableViewController.h"

#import "Course2ViewController.h" //课程类型2
#import "CourseViewController.h"

#import "VipViewController.h"

#import "JobsViewController.h"
#import "AppDelegate.h"


#import "Config.h"
@interface MainContentBarController ()<UISearchBarDelegate>{
 
    CourseViewController* courseCtl;
    Course2ViewController* course2Ctl ;
    VipViewController* vipCtl;
    CorporationTableViewController * corporationCtl;
    JobsViewController* jobsCtl;
    
}

@end

@implementation MainContentBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.translucent = NO;

    //课程培训
//    courseCtl = [[CourseViewController alloc ]init];
//    UINavigationController* coursenav = [[UINavigationController alloc]initWithRootViewController:courseCtl  ];
//    [coursenav setNavigationBarHidden:YES];
    
       //k课程类型2
    course2Ctl  = [Course2ViewController new];
    UINavigationController* coursenav = [[UINavigationController alloc]initWithRootViewController:course2Ctl  ];
   //  [coursenav setNavigationBarHidden:YES];
    
    
    
    //会员
    vipCtl = [VipViewController new];
    UINavigationController * vipnav = [[UINavigationController alloc]initWithRootViewController:vipCtl];
    vipCtl.navigationItem.title=@"VIP会员";
    
    
    
    //公司
    corporationCtl = [CorporationTableViewController new];
    UINavigationController * cornav = [[UINavigationController alloc]initWithRootViewController:corporationCtl ];
    corporationCtl.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(SearchConfig)];
    corporationCtl.navigationItem.title = @"公司";
    
    corporationCtl.needCache = YES;
    //职位
    
    jobsCtl = [JobsViewController new];
    UINavigationController* jobnav = [[UINavigationController alloc]initWithRootViewController:jobsCtl];
    jobsCtl.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(SearchConfig)];
    
    jobsCtl.navigationItem.title = @"公司";
    jobsCtl.needCache = YES;
    
    //设置
    UIStoryboard * settingSB = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    UINavigationController * settingsNav = [settingSB instantiateViewControllerWithIdentifier:@"nav"];
    
    
    
    //tab
    self.viewControllers =@[
                            coursenav,
                            cornav,
                            jobnav,
                            vipnav,
                            settingsNav
                            ];
    NSArray* titles = @[@"培训",@"公司",@"职位",@"会员",@"设置"];
    NSArray* images = @[@"video_1",@"cor",@"job",@"vip",@"icon_setting_normal"
                        ];
    
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        [item setTitle:titles[idx]];
        [item setImage:[UIImage imageNamed:images[idx]]];
        [item setSelectedImage:[UIImage imageNamed:[images[idx] stringByReplacingOccurrencesOfString:@"normal" withString:@"pressed"]]];
         
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)SearchConfig{
    
    UISearchBar * searchbar = [UISearchBar new];
    searchbar.delegate =self;
    searchbar.placeholder =@"请输入关键词";
    ((AppDelegate*)([UIApplication sharedApplication]).delegate).inNightMode =[Config getMode];
    if(((AppDelegate*)([UIApplication sharedApplication]).delegate).inNightMode){
        searchbar.keyboardAppearance=UIKeyboardAppearanceDark;
        searchbar.barTintColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    }
    corporationCtl.navigationItem.titleView = searchbar;
    
}

@end
