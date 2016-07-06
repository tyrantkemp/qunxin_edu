//
//  CourseViewController.m
//  qunxin_edu
//
//  Created by 肖准 on 6/14/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "CourseViewController.h"
#import "GWAutoSlideScrollView.h"

@interface CourseViewController ()<GWAutoSlideScrollViewDelegate,UIGestureRecognizerDelegate>{
    NSMutableArray* _scrollImgUrls;
}
@property (nonatomic, strong) GWAutoSlideScrollView *autoSlideScrollView;

@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //设置图片循环滚动，如果偏移位置大于330，则设置为330
    if (self.autoSlideScrollView.scrollView.contentOffset.x > CGRectGetWidth(self.view.bounds)) {
        self.autoSlideScrollView.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.view.bounds)*2, 0);
    }
    
    
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


#pragma mark - tableview 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return screenheight/5;
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell= nil;
    if(indexPath.row == 0){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"level0"];
        //大数据
        UIView* bigdataview = [UIView new];
        [bigdataview setBackgroundColor:[UIColor colorWithRed:0.988 green:0.298 blue:0.388 alpha:1.000]];
        [cell.contentView addSubview:bigdataview];

        [bigdataview zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
           
            layout.edgeInsets(UIEdgeInsetsMake(5, 5, 5, (screenwith-20)/3+25));
        }];
     
        UILabel *bigdataLB = [UILabel new];
        [bigdataLB setTextColor:[UIColor whiteColor]];
        [bigdataLB setText:@"大数据应用"];
        [bigdataLB setFont:[UIFont systemFontOfSize:17]];
        [bigdataview addSubview:bigdataLB];
        [bigdataLB zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
            layout.leftSpace(5).bottomSpace(5);
        }];
        
        UITapGestureRecognizer* datatap = [UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            sender.view.backgroundColor = [UIColor colorWithRed:0.885 green:0.168 blue:0.320 alpha:1.000];
            NSLog(@"大数据点击");
            dispatch_after (dispatch_time (DISPATCH_TIME_NOW, (int64_t )(0.1 * NSEC_PER_SEC )), dispatch_get_main_queue (), ^{
                sender.view.backgroundColor = [UIColor colorWithRed:0.988 green:0.298 blue:0.388 alpha:1.000];
            });
            
        }];
        datatap.delegate = self;
        [bigdataview addGestureRecognizer:datatap];
        
        
        
        //安卓
        UIView* andriodview = [UIView new];
        [andriodview setBackgroundColor:[UIColor colorWithRed:0.996 green:0.769 blue:0.153 alpha:1.000]];
        [cell.contentView addSubview:andriodview];

        [andriodview zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
            layout.topSpace(5).bottomSpace(5).leftSpaceByView(bigdataview,5).rightSpace(5);
        }];
        
        UILabel *andriodLB = [UILabel new];
        [andriodLB setTextColor:[UIColor whiteColor]];
        [andriodLB setText:@"安卓开发"];
        [andriodLB setFont:[UIFont systemFontOfSize:17]];
        [andriodview addSubview:andriodLB];
        [andriodLB zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
            layout.leftSpace(5).bottomSpace(5);
        }];
        
        UITapGestureRecognizer* andriodtap = [UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            sender.view.backgroundColor = [UIColor colorWithRed:0.921 green:0.652 blue:0.052 alpha:1.000];
            NSLog(@"安卓点击");
            dispatch_after (dispatch_time (DISPATCH_TIME_NOW, (int64_t )(0.1 * NSEC_PER_SEC )), dispatch_get_main_queue (), ^{
                sender.view.backgroundColor = [UIColor colorWithRed:0.996 green:0.769 blue:0.153 alpha:1.000];
            });
            
        }];
        andriodtap.delegate = self;
        [andriodview addGestureRecognizer:andriodtap];
        
    }else if(indexPath.row == 1){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"level1"];
        
        //java
        UIView* javaview = [UIView new];
        [javaview setBackgroundColor:[UIColor colorWithRed:0.498 green:0.212 blue:0.941 alpha:1.000]];
        [cell.contentView addSubview:javaview];
        
        [javaview zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
            
            layout.edgeInsets(UIEdgeInsetsMake(0, 5, 5, (screenwith-20)/3*2+15));
        }];
        
        UILabel *javaLB = [UILabel new];
        [javaLB setTextColor:[UIColor whiteColor]];
        [javaLB setText:@"Java"];
        [javaLB setFont:[UIFont systemFontOfSize:17]];
        [javaview addSubview:javaLB];
        [javaLB zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
            layout.leftSpace(5).bottomSpace(5);
        }];
        
        UITapGestureRecognizer* javatap = [UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            sender.view.backgroundColor = [UIColor colorWithRed:0.270 green:0.000 blue:0.434 alpha:1.000];
            NSLog(@"java点击");
            dispatch_after (dispatch_time (DISPATCH_TIME_NOW, (int64_t )(0.1 * NSEC_PER_SEC )), dispatch_get_main_queue (), ^{
                sender.view.backgroundColor = [UIColor colorWithRed:0.498 green:0.212 blue:0.941 alpha:1.000];
            });
            
        }];
        javatap.delegate = self;
        [javaview addGestureRecognizer:javatap];
        

        
        //前端
        UIView* htmlview = [UIView new];
        [htmlview setBackgroundColor:[UIColor orangeColor]];
        [cell.contentView addSubview:htmlview];
        
        [htmlview zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
            layout.topSpace(0).bottomSpace(5).leftSpaceByView(javaview,5).rightSpace(5);
        }];
        
        UILabel *htmlLB = [UILabel new];
        [htmlLB setTextColor:[UIColor whiteColor]];
        [htmlLB setText:@"前端"];
        [htmlLB setFont:[UIFont systemFontOfSize:17]];
        [htmlview addSubview:htmlLB];
        [htmlLB zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
            layout.leftSpace(5).bottomSpace(5);
        }];
        
        UITapGestureRecognizer* htmltap = [UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            sender.view.backgroundColor = [UIColor colorWithRed:0.954 green:0.306 blue:0.042 alpha:1.000];
            NSLog(@"前端点击");
            dispatch_after (dispatch_time (DISPATCH_TIME_NOW, (int64_t )(0.1 * NSEC_PER_SEC )), dispatch_get_main_queue (), ^{
                sender.view.backgroundColor = [UIColor orangeColor];
            });
            
        }];
        htmltap.delegate = self;
        [htmlview addGestureRecognizer:htmltap];
        
        
    }else if(indexPath.row == 2){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"level2"];
    }
    else if(indexPath.row ==3){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"level3"];
        
    }
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    
    return cell;
    
    
    
    
    
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
