//
//  searchTableViewController.m
//  qunxin_edu
//
//  Created by 肖准 on 6/30/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "searchTableViewController.h"

@interface searchTableViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>{
    UISearchBar* _searchbar;
    
    
    UIView* _maskview;
}


@end

@implementation searchTableViewController

-(instancetype)init{
    self = [super init];
    if(self){
        __weak searchTableViewController * searCtl =self;
        searCtl.generateURL = ^NSString*(NSUInteger page){
        
            return @"http://www.baidu.com";
        };
        self.tableWillReload = ^(NSUInteger count){
            (count<20)?(searCtl.lastCell.status = LastCellStatusFinished):(searCtl.lastCell.status = LastCellStatusMore);
            
        };
        
        self.objClass = [searchTableViewController class];
        self.needCache = YES;
        self.shouldFetchDataAfterLoaded = NO;
        self.needAutoRefresh =NO;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //tableview 不扩展 只在bar和navigation之间显示 默认UIRectEdgeAll
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {self.edgesForExtendedLayout= UIRectEdgeNone;
    }
    [self.view setBackgroundColor:[UIColor colorWithRed:0.902 green:0.902 blue:0.941 alpha:1.000]];
    
    
    //导航栏中的搜索栏
    _searchbar = [UISearchBar new];
    _searchbar.delegate =self;
    _searchbar.placeholder =@"请输入关键词";
    self.navigationItem.titleView = _searchbar;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
    
    //遮盖层
    [self initmask];
   
    
    //uitableview添加shoushi
    UITapGestureRecognizer* tap = [UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        if([sender.view isKindOfClass:[UITableView class]]){
            [_searchbar resignFirstResponder];
           // [self maskhide];
        }
        
    }];
    tap.delegate = self;
    [self.tableView addGestureRecognizer:tap];
    
    
    // Do any additional setup after loading the view.
}

#pragma mark- 遮盖层生成
-(void)initmask{
    _maskview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenwith, screenheight/4)];
    //   [_maskview setBackgroundColor:[UIColor colorWithWhite:1.000 alpha:0.585]];
    [_maskview setBackgroundColor:[UIColor colorWithRed:0.365 green:0.780 blue:0.145 alpha:1.000]];
    _maskview.hidden = YES;
    [self.view addSubview:_maskview];
    
}




-(void)search{
    NSLog(@"点击搜索");
    
    NSString* searchtext =  [_searchbar.text StringWithoutEmpty];
    if(searchtext.length==0){
        return ;
    }
    __weak searchTableViewController * searCtl =self;
    searCtl.generateURL = ^NSString*(NSUInteger page){
        NSString* url = [NSString stringWithFormat:@"%@%@%@?name=%@&pageIndex=%lu&%@", MAIN, COURSE, GETCOURSE_BY_SEARCH,searchtext,(unsigned long)page, MAIN_SUFFIX];
        NSLog(@"根据条件获取课程信息 url:%@",url);
        return @"http://www.baidu.com";
    };
    
    //点击搜索刷新数据
    [self refresh];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
    
    NSLog(@"viewWillAppear");
    self.navigationController.navigationBar.translucent = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [_searchbar resignFirstResponder];
}


#pragma mark - 捕获界面点击
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch");
    [touches enumerateObjectsUsingBlock:^(UITouch * _Nonnull obj, BOOL * _Nonnull stop) {
        if(![((UITouch*)obj).view isKindOfClass:[UISearchBar class]]){
            [_searchbar resignFirstResponder];
        }
    }];
    
}
#pragma mark - 搜索栏
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"search return key pressed");
    
    [self search];
    
    [searchBar resignFirstResponder];
    
}// called when keyboard search button pressed

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
//    CATransition *animation = [CATransition animation]; //animation.delegate = self;
//    animation.duration = 0.4f;
//    animation.type = kCATransitionMoveIn;
//    animation.subtype = kCATransitionFromBottom;
//    [_maskview.layer addAnimation:animation forKey:@"animation"];
//    _maskview.hidden = NO;

    
}

-(void)maskhide{
    CATransition *animation = [CATransition animation]; //animation.delegate = self;
    animation.duration = 0.4f;
    animation.type = kCATransitionReveal;
    animation.subtype = kCATransitionFromTop;
    [_maskview.layer addAnimation:animation forKey:@"animation"];
    _maskview.hidden = YES;
}


#pragma mark - uitableview


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.objects count];;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"search_table_cell"];
    
    
    return  cell;
    
}

-(NSArray*)parseJson:(id) responseObject{
    return nil;
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
