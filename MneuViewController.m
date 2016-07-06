//
//  MneuViewController.m
//  qunxin_edu
//
//  Created by 肖准 on 6/28/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "MneuViewController.h"
#import "UIImage+Util.h"
#import "MenuView.h"
#import "refrenceTableViewCell.h"
#import "searchTableViewController.h"
static NSString* cellId = @"menutable_cell_id";
@interface MneuViewController ()<UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate>{
    
    UIView* _maskView;
    MenuView * _menuview;
    UIButton* _catoBtn;
    UIButton * _newBtn;
    UIButton* _hotBtn;

}

@end

@implementation MneuViewController

-(instancetype)init{
    self = [super init];
    if(self){
        
        __weak MneuViewController * menuCtl =self;
        menuCtl.generateURL = ^NSString*(NSUInteger page){
            NSString* url = [NSString stringWithFormat:@"%@%@?pageIndex=%lu&%@", MAIN_PREFIX, MAIN_CORPORATION, (unsigned long)page, MAIN_SUFFIX];
            NSLog(@"获取工作信息url:");
            return @"http://www.baidu.com";
        };
        
        self.tableWillReload = ^(NSUInteger count){
            (count<20)?(menuCtl.lastCell.status = LastCellStatusFinished):(menuCtl.lastCell.status = LastCellStatusMore);
            
        };
        
        self.objClass = [MneuViewController class];
        self.needCache = YES;
        self.needAutoRefresh = NO;
        //self.refreshInterval = 21600;
        //self.kLastRefreshTime = @"menuRefreshInterval";
        
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
    
    
    [self.tableView registerClass:[refrenceTableViewCell class] forCellReuseIdentifier:cellId];
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.937 alpha:1.000]];
    
    [self initMask];
    

    
}
#pragma  nark - 点击进入搜索视图
-(void)search{
    searchTableViewController *searchctl = [searchTableViewController new];
    searchctl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchctl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark - 遮盖层
-(void)initMask{
    
    _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 35+self.tableView.contentOffset.y, screenwith, screenheight-64-35)];
    _maskView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.352];
    [self.view addSubview:_maskView];
    _maskView.hidden = YES;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMaskView:)];
    tap.delegate = self;
    [_maskView addGestureRecognizer:tap];
    
    _menuview = [[MenuView alloc]initWithFrame:CGRectMake(0, 0, screenwith, _maskView.frame.size.height-90)];
    
    __weak typeof(self) weakself= self;
    _menuview.didselectAtrowWithId = ^(NSInteger Id){
        NSLog(@"点击课程菜单:%d",Id);
        [weakself catohidden];
        
        //
    };
    
    [_maskView addSubview:_menuview];
    
}
#pragma mark - 点击遮盖层
-(void)tapMaskView:(UITapGestureRecognizer*) sender{
    [self catohidden];
}

#pragma mark - tableview 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return screenheight/8;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
        return 40;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView * headerview = [UIView new];
    [headerview setBounds:CGRectMake(0, 0, screenwith, 40)];
    [headerview setBackgroundColor:[UIColor colorWithWhite:0.937 alpha:1.000]];

    
    UIView * toolview = [UIView new];
    [toolview setFrame:CGRectMake(0, 0, screenheight, 40)];
    [toolview setBackgroundColor:[UIColor whiteColor]];
    [headerview addSubview:toolview];
    
    //课程类别
    _catoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_catoBtn setTitle:@"课程类别" forState:UIControlStateNormal];
    [_catoBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_catoBtn setTitleColor:[UIColor colorWithRed:0.128 green:0.883 blue:0.526 alpha:1.000] forState:UIControlStateSelected];
    [_catoBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_catoBtn bk_addEventHandler:^(UIButton* sender) {

        if(sender.selected == NO){
            _newBtn.selected = NO;
            _hotBtn.selected =NO;
            [self catoshow];
        }else {
            [self catohidden];
        }
        
        NSLog(@"点击 课程类别");
    } forControlEvents:UIControlEventTouchUpInside];
    
    [toolview addSubview:_catoBtn];
    
    [_catoBtn zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpace(10).topSpace(2).bottomSpace(2).heightValue(toolview.frame.size.height-4);
        
    }];
    
    //课程最新
    _newBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_newBtn setTitle:@"最新" forState:UIControlStateNormal];
    [_newBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_newBtn setTitleColor:[UIColor colorWithRed:0.128 green:0.883 blue:0.526 alpha:1.000] forState:UIControlStateSelected];
    [_newBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_newBtn bk_addEventHandler:^(UIButton* sender) {
        
        if(sender.selected == NO){
            sender.selected =YES;
            _hotBtn.selected = NO;
            [self catohidden];

            
        }else {
            sender.selected =NO;
        }
        
        NSLog(@"点击 课程最新");
    } forControlEvents:UIControlEventTouchUpInside];
    
    [toolview addSubview:_newBtn];
    
    [_newBtn zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpace(screenwith/3+20).topSpace(2).bottomSpace(2).heightValue(toolview.frame.size.height-4);
        
    }];
    
    //课程热度
    _hotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_hotBtn setTitle:@"最火" forState:UIControlStateNormal];
    [_hotBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_hotBtn setTitleColor:[UIColor colorWithRed:0.128 green:0.883 blue:0.526 alpha:1.000] forState:UIControlStateSelected];
    [_hotBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_hotBtn bk_addEventHandler:^(UIButton* sender) {
        
        if(sender.selected == NO){
            sender.selected =YES;
            _newBtn.selected = NO;
            [self catohidden];

            
        }else {
            sender.selected =NO;
        }
        
        NSLog(@"点击 热门课程");
    } forControlEvents:UIControlEventTouchUpInside];
    
    [toolview addSubview:_hotBtn];
    
    [_hotBtn zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpace(screenwith/3*2+20).topSpace(2).bottomSpace(2).heightValue(toolview.frame.size.height-4);
        
    }];
    
    
    return headerview;
    
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    refrenceTableViewCell *cell = [[refrenceTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId course:nil cellheight:screenheight/8];
    cell.rightUtilityButtons = [self rightButtons];
    cell.delegate = self;
    
    return cell;
    
}
-(NSArray*)rightButtons{
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



-(NSArray*)parseJson:(id) responseObject{
   // NSAssert(false, @"Over ride in subclasses");
    return nil;
}


#pragma mark - 课程类别
-(void)catohidden{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFromTop;
    animation.duration = 0.2;
    [_maskView.layer addAnimation:animation forKey:nil];
    _maskView.hidden = YES;
    _menuview.hidden = YES;
    self.tableView.scrollEnabled =YES;
    _catoBtn.selected = NO;
}
-(void)catoshow{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFromBottom;
    animation.duration = 0.2;
    [_maskView.layer addAnimation:animation forKey:nil];
    _maskView.hidden = NO;
    _menuview.hidden = NO;

    self.tableView.scrollEnabled =NO;
    _catoBtn.selected = YES;
}




#pragma mark - 手势 delegate 
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
  //  NSLog(@"view class:%@",[touch.view class]);
//    if([touch.view isKindOfClass:[UITableView class]]){
//        return NO;
//    }
  //  NSLog(@"frame:%@",NSStringFromCGRect(_menuview.frame));

    CGPoint p = [touch locationInView:_maskView];
    //NSLog(@"frame:%@",NSStringFromCGPoint(p));

    if(CGRectContainsPoint (_menuview.frame, p)){
        return NO;
    }
    return YES;
}


#pragma mark- 课程按条件搜索 最火or最热 在主couseId的搜索条件下
-(void)searchByCondition{
    
    __weak MneuViewController * searCtl =self;
    searCtl.generateURL = ^NSString*(NSUInteger page){
//        NSString* url = [NSString stringWithFormat:@"%@%@%@?name=%@&pageIndex=%lu&%@", MAIN, COURSE, GETCOURSE_BY_SEARCH,searchtext,(unsigned long)page, MAIN_SUFFIX];
    //    NSLog(@"根据条件获取课程信息 url:%@",url);
        return @"http://www.baidu.com";
    
    };
    
    //点击搜索刷新数据
    [self refresh];
    
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
