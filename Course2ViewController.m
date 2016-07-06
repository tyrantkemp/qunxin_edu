//
//  Course2ViewController.m
//  qunxin_edu
//
//  Created by 肖准 on 6/21/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "Course2ViewController.h"
#import <MBProgressHUD.h>
#import "GWAutoSlideScrollView.h"
#import "Course2TableViewCell.h"
#import "courseView.h"
#import "CourseDetailViewController.h"
#import "MneuViewController.h"
#import "searchTableViewController.h"
#import "searchTableViewController.h"

#import "courseMJ.h"



static NSString* cellId= @"course2_cell_id";

@interface Course2ViewController ()<GWAutoSlideScrollViewDelegate,UIGestureRecognizerDelegate,UISearchBarDelegate>{
    AFHTTPSessionManager* _manager;
    NSMutableArray* _scrollImgUrls;
    
    NSMutableArray* _courseHotArr;
    NSMutableArray* _courseNewArr;
    NSMutableArray* _courseFreeArr;

}
@property (nonatomic, strong) GWAutoSlideScrollView *autoSlideScrollView;

@end

@implementation Course2ViewController


-(instancetype)init{
    self = [super init];
    if(self){
         _courseHotArr = [NSMutableArray new];
         _courseNewArr = [NSMutableArray new];
         _courseFreeArr = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self preSet];
    
    [self.tableView registerClass:[Course2TableViewCell class] forCellReuseIdentifier:cellId];
    
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.937 alpha:1.000]];
    
    
    
    
    _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    _manager = [AFHTTPSessionManager manager];
    _manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;

    //下拉刷新的view
    self.tableView.mj_header = ({
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        header.lastUpdatedTimeLabel.hidden = NO;
        header.stateLabel.hidden = NO;
        header;
    });
    [self.tableView.mj_header beginRefreshing];
    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentOffset.y-self.refreshControl.frame.size.height)
                            animated:YES];
    
    
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    _scrollImgUrls = [[NSMutableArray alloc]init];
    [_scrollImgUrls addObject:@"http://www.feizl.com/upload2007/2013_02/130227014423722.jpg"];
    [_scrollImgUrls addObject:@"http://www.feizl.com/upload2007/2013_02/130227014423723.jpg"];
    [_scrollImgUrls addObject:@"http://www.feizl.com/upload2007/2013_02/130227014423721.jpg"];
    [_scrollImgUrls addObject:@"http://www.feizl.com/upload2007/2013_02/130227014423722.jpg"];
    [_scrollImgUrls addObject:@"http://www.feizl.com/upload2007/2013_02/130227014423725.jpg"];
    
    self.autoSlideScrollView.imageArray = _scrollImgUrls;
    
    // [self.view addSubview:self.autoSlideScrollView];
    
    self.tableView.tableHeaderView =self.autoSlideScrollView;
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //navigationbar 透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    
    
    //设置图片循环滚动，如果偏移位置大于330，则设置为330
    if (self.autoSlideScrollView.scrollView.contentOffset.x > CGRectGetWidth(self.view.bounds)) {
        self.autoSlideScrollView.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.view.bounds)*2, 0);
    }
}

-(void)preSet{
    
    UIBarButtonItem* menubtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu_1"] style:UIBarButtonItemStyleBordered target:self action:@selector(menuPress:)];
    self.navigationItem.leftBarButtonItem = menubtn;
    
    UIBarButtonItem* searchbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStyleBordered target:self action:@selector(searchPress:)];
    self.navigationItem.rightBarButtonItem = searchbtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 课程菜单
-(void)menuPress:(UIButton*)sender{
    NSLog(@"课程菜单点击");
    
    MneuViewController* menuctl = [MneuViewController new];
 
    menuctl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:menuctl animated:YES];
    
    
}

#pragma  mark -  搜索视图
-(void)searchPress:(UIButton*)sender{
    NSLog(@"课程搜索点击");
  //  searchViewController* searchctl = [searchViewController new];

    searchTableViewController * searchctl = [searchTableViewController new];
    searchctl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchctl animated:YES];
    
    
}
#pragma mark - 刷新

- (void)refresh
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
        [self fetchData:YES];
    });
 
}


#pragma mark - 获取数据
-(void)fetchData:(BOOL)refresh{
    NSLog(@"下拉刷新");
    
    NSString* url = [NSString stringWithFormat:@"%@%@%@", MAIN, COURSE,GETCOURSEINFO];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//                    if (self.tableView.mj_header.isRefreshing) {
//                        [self.tableView.mj_header endRefreshing];
//                    }
//        
//                    [self.tableView reloadData];
//        
//                    
//                });
    
    
    
    [[XZHttp sharedInstance] getWithURLString:url parameters:nil success:^(id responseObject) {

        
        
        if(refresh){
            [_courseHotArr removeAllObjects];
            [_courseNewArr removeAllObjects];
            [_courseFreeArr removeAllObjects];
        }
        [self parseJson:responseObject];

        
        
//        for(RLMObject* item in objectJson){
//            if([_objects containsObject:item]){
//                continue;
//            }else {
//                [_objects addObject:item];
//            }
//            
//        }
//        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.tableView.mj_header.isRefreshing) {
                [self.tableView.mj_header endRefreshing];
            }
            
            [self.tableView reloadData];
            
            
        });
        
    } failure:^(NSError *error) {
        MBProgressHUD *HUD = [Utils createHUD];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
        HUD.detailsLabelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
        
        [HUD hide:YES afterDelay:1];
        
        if (self.tableView.mj_header.isRefreshing) {
            [self.tableView.mj_header endRefreshing];
        }
        [self.tableView reloadData];
    }];

    
   
    
}

#pragma mark- 课程数据生成 
-(NSArray*)parseJson:(id)responseObject{
    //NSDictionary*dic= responseObject[@"data"];
    
 
 
 //   NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
   // responseString = [responseString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    //responseString = [responseString substringWithRange:NSMakeRange(1, [responseString length]-2)];
    NSDictionary *json = [Utils getJsonStringFromResponseObj:responseObject];
    NSDictionary* coursedict = json[@"data"];
    NSArray* course0 = coursedict[@"recommand"];
    NSArray* course1 = coursedict[@"latest"];
    NSArray* course2 = coursedict[@"free"];

    
//    RLMRealm* realm = [RLMRealm defaultRealm];
//    [realm beginWriteTransaction];
//    _courseHotArr =[[Course createOrUpdateInRealm:realm withJSONArray:course0] mutableCopy];
//    _courseNewArr =[[Course createOrUpdateInRealm:realm withJSONArray:course1] mutableCopy];
//    _courseFreeArr =[[Course createOrUpdateInRealm:realm withJSONArray:course2] mutableCopy];
//    
//    
//    
//    [realm commitWriteTransaction];
//    

    _courseHotArr =[courseMJ mj_objectArrayWithKeyValuesArray:course0];
    _courseNewArr = [courseMJ mj_objectArrayWithKeyValuesArray:course1];
    _courseFreeArr = [courseMJ mj_objectArrayWithKeyValuesArray:course2];
    
    
    //
    //    RLMRealm* realm = [RLMRealm defaultRealm];
    //    [realm beginWriteTransaction];
    //    NSArray * res =[CorInfo createOrUpdateInRealm:realm withJSONArray:json];
    //    [realm commitWriteTransaction];
    //    NSLog(@"公司具体信息：%@",res);
    
    //    // NSArray * arr = responseObject;
    //    //NSArray *arr =  [NSKeyedUnarchiver unarchiveObjectWithData:responseObject];
    //    RLMRealm * reaml =[RLMRealm defaultRealm];
    //    [reaml beginWriteTransaction];
    //    NSArray* res = [Corporation createOrUpdateInRealm:reaml withJSONArray:json];
    //    [reaml commitWriteTransaction];
    //    NSLog(@"公司：%@",res);
    
    
    
    return nil;
    
    
}

#pragma mark - 轮播初始化

- (GWAutoSlideScrollView *)autoSlideScrollView {
    if (!_autoSlideScrollView) {
        _autoSlideScrollView = [[GWAutoSlideScrollView alloc] initWithFrame:CGRectMake(0, 0, screenwith, screenheight/4)];
        _autoSlideScrollView.delegate = self;
        _autoSlideScrollView.backgroundColor = [UIColor colorWithRed:0.893 green:0.890 blue:0.441 alpha:1.000];
        _autoSlideScrollView.scrollView.scrollsToTop = NO;
    }
    return _autoSlideScrollView;
}
#pragma mark - GWAutoSlideScrollViewDelegate
- (void)autoSlideScrollView:(GWAutoSlideScrollView *)autoSlideScrollView didSelectAtIndex:(NSInteger)index {
    NSLog(@"index = %ld",(long)index);
}



#pragma mark - tableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return screenheight/4;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    NSInteger row  = [indexPath row];
    Course2TableViewCell* cell = nil;
    switch (row) {
        case 0:
            cell = [[Course2TableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId courseArray:_courseHotArr courseType:0 height:screenheight/4];
            
            break;
        case 1:
            cell = [[Course2TableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId courseArray:_courseNewArr courseType:1 height:screenheight/4];
            
            break;
        case 2:
            cell = [[Course2TableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId courseArray:_courseFreeArr courseType:2 height:screenheight/4];
            break;
    
        default:
            break;
    }
    
    NSLog(@"数目:%d",cell.objects.count);
    
    
    [cell.objects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        ((courseView*)obj).courseTap = ^(NSString* url){
            NSLog(@"%@ -- 跳转的课程视频播放页面",url);
            CourseDetailViewController* coursectl = [CourseDetailViewController new];
            [coursectl setUrl:@"获取视频信息"];
            coursectl.sectionId = 10;
            coursectl.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:coursectl animated:YES];
            
        };
        
    }];
    
    //tableView.allowsSelection = NO;

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return  cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NSLog(@"cell点击");
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
