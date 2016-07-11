//
//  JobsViewController.m
//  qunxin_edu
//
//  Created by 肖准 on 6/13/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "JobsViewController.h"
#import "Job.h"
#import "CorInfoTableViewCell.h"
#import "JobConditionView.h"
#import "UIButton+create.h"
#import "UIView+Util.h"
static NSString* cellId = @"jobcell";

@interface JobsViewController ()<UIGestureRecognizerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    UIView *_headerview;
    UIView *_maskView;
    
    UIView *_savView;
    UIButton *_salarybtn;
    NSArray* _savArr;
    NSString* _savRange;
    
    
    
    UIView *_expView;
    UIButton* _exprebtn;
    NSArray* _expArr;
    NSString* _expRange;
    
    UIView *_corView;
    UIButton* _corBtn;
}

@end

@implementation JobsViewController
-(instancetype)init{
    self = [super init];
    if(self){
        
        __weak JobsViewController * jobCtl =self;
        jobCtl.generateURL = ^NSString*(NSUInteger page){
        
         NSString* url = [NSString stringWithFormat:@"%@%@?pageIndex=%lu&%@", MAIN_PREFIX, MAIN_CORPORATION, (unsigned long)page, MAIN_SUFFIX];
            NSLog(@"获取工作信息url:");
            return @"http://www.baidu.com";
        };
        
        self.tableWillReload = ^(NSUInteger count){
            (count<20)?(jobCtl.lastCell.status = LastCellStatusFinished):(jobCtl.lastCell.status = LastCellStatusMore);
            
        };
        
        self.objClass = [JobsViewController class];
        self.needCache = YES;
        self.needAutoRefresh = NO;
        //self.refreshInterval = 21600;
        //self.kLastRefreshTime = @"jobsRefreshInterval";
        
    }
    return self;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    _maskView.hidden = YES;
    _salarybtn.selected =NO;
    _exprebtn.selected = NO;
    _corBtn.selected = NO;
    self.tableView.scrollEnabled=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[CorInfoTableViewCell class] forCellReuseIdentifier:cellId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CorInfoTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.jobindexLabel.text = [NSString stringWithFormat:@"职位%d",indexPath.row];
    cell.salaryLabel.text  = [NSString stringWithFormat:@"￥%dK-%dK",5,10];
    cell.subInfoLabel.text  = [NSString stringWithFormat:@"%@ %@年 %@",@"广州",@"3-5",@"本科"];
    cell.jobNameLabel.text = @"CEO";
    cell.corNameLabel.text = @"百度";
    cell.updateLabel.text =@"跟新日期:2016-06-12";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
#pragma mark - tableview header 条件过滤
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    _headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 64, screenwith, 40)];
    
    
    //薪金按钮
    _salarybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_salarybtn setFrame:CGRectMake(0, 0, screenwith/3, 39)];
    _salarybtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_salarybtn setTitle:@"薪金" forState:UIControlStateNormal];
  //  [_salarybtn addTarget:self action:@selector(headerBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [_salarybtn bk_addEventHandler:^(UIButton* sender) {
        if(_maskView.hidden==NO){
            _maskView.hidden = YES;
        }
        _exprebtn.selected = NO;
        _corBtn.selected=NO;
        
        if(sender.selected == NO){
            [self initMask];
            [self initSavView];
            sender.selected = YES;
        }else {
            _maskView.hidden =YES;
            [_savView removeFromSuperview];
            sender.selected = NO;
        }

    } forControlEvents:UIControlEventTouchUpInside];
    [_salarybtn setTitleColor:[UIColor colorWithRed:0.128 green:0.883 blue:0.526 alpha:1.000] forState:UIControlStateSelected];
    [_salarybtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_headerview addSubview:_salarybtn];
    
    
    //经验按钮
    _exprebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_exprebtn setFrame:CGRectMake(screenwith/3, 0,screenwith/3, 39)];
    _exprebtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_exprebtn setTitle:@"经验" forState:UIControlStateNormal];
    [_exprebtn bk_addEventHandler:^(UIButton* sender) {
        if(_maskView.hidden==NO){
            _maskView.hidden = YES;
        }
        
        _salarybtn.selected = NO;
        _corBtn.selected=NO;
        if(sender.selected == NO){
            [self initMask];
            [self initExpView];
            sender.selected = YES;
        }else {
            _maskView.hidden =YES;
            [_expView removeFromSuperview];
            sender.selected = NO;
        }
        
    } forControlEvents:UIControlEventTouchUpInside];
    [_exprebtn setTitleColor:[UIColor colorWithRed:0.128 green:0.883 blue:0.526 alpha:1.000] forState:UIControlStateSelected];
    [_exprebtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_headerview addSubview:_exprebtn];
    
    
    //公司规模按钮
    _corBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_corBtn setFrame:CGRectMake(screenwith/3*2, 0,screenwith/3, 39)];
    _corBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_corBtn setTitle:@"公司类型" forState:UIControlStateNormal];
    [_corBtn bk_addEventHandler:^(UIButton* sender) {
        if(sender.selected == NO){
            [self initMask];
            [self initCorView];
            sender.selected = YES;
        }else {
            _maskView.hidden =YES;
            [_corView removeFromSuperview];
            sender.selected = NO;
        }
        
    } forControlEvents:UIControlEventTouchUpInside];
    [_corBtn setTitleColor:[UIColor colorWithRed:0.128 green:0.883 blue:0.526 alpha:1.000] forState:UIControlStateSelected];
    [_corBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_headerview addSubview:_corBtn];
    
    
    [_headerview setBackgroundColor:[UIColor colorWithWhite:1.000 alpha:0.919]];

    return _headerview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}


-(NSArray*)parseJson:(id)responseObject{
    //  NSArray *json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
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
-(void)headerBtnPress:(UIButton*)sender{
    
    if(sender == _salarybtn){
        if(_salarybtn.selected==YES){
            
            _salarybtn.selected = NO;
        }else {
            
            
            _salarybtn.selected=YES;
        }
    }else if(sender == _exprebtn){
        
    }
    
    
    if(sender.selected == NO){
        [self initMask];
        [self initSavView];
        sender.selected = YES;
    }else {
        _maskView.hidden =YES;
        [_savView removeFromSuperview];
        sender.selected = NO;
    }

}
-(void)exprebtnPress:(UIButton*) btn{
    
    
}
-(void)corbtnPress:(UIButton*) btn{
    
    
}

#pragma  mark - 遮盖层
-(void)initMask{
    
    self.tableView.scrollEnabled =NO;
    _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 40+self.tableView.contentOffset.y, screenwith, screenheight-64-40)];
    _maskView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.352];
    
    [self.view addSubview:_maskView];
    _maskView.hidden = YES;

        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMaskView:)];
        tap.delegate = self;
        [_maskView addGestureRecognizer:tap];
    
    
}

#pragma mark - 点击遮盖层
-(void)tapMaskView:(UITapGestureRecognizer*) sender{
    _maskView.hidden = YES;
    _salarybtn.selected =NO;
    _exprebtn.selected = NO;
    self.tableView.scrollEnabled=YES;
    
}

#pragma mark - 薪水

-(void)initSavView{
    
    _maskView.hidden = NO;
    
    _savView = [[UIView alloc]initWithFrame:CGRectMake(20, -300, screenwith-40, _maskView.frame.size.height-200)] ;
    [_maskView addSubview:_savView];
    
    _savView.backgroundColor = [UIColor whiteColor];
    
    UIButton* removebtn = [UIButton createButtonWithFrame:CGRectMake(10, 10, 20, 20) Target:self Selector:@selector(removeBtnPress:) Image:@"quit_art_normal" ImagePressed:@"quit_art_pressed"];
    [_savView addSubview:removebtn];
    
    UIButton* confirmbtn = [UIButton createButtonWithFrame:CGRectZero Title:@"确定" Target:self Selector:@selector(confirmbtnPress:)];
    confirmbtn.backgroundColor = [UIColor colorWithRed:0.109 green:0.849 blue:0.984 alpha:1.000];
    [confirmbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       [_savView addSubview:confirmbtn];
    [confirmbtn zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.bottomSpace(20);
        layout.heightValue(30);
        layout.widthValue(80);
        layout.leftSpace(_savView.frame.size.width/2-40);
        
    }];
    //薪金范围
    _savArr = [NSArray arrayWithObjects:@"3k-4k",@"4k-5k",@"5k-6k",@"6k-7k",@"7k-10k",@"10k-15k" ,nil];
    _savRange = _savArr[0];
    //选择器
    UIPickerView* savPiker = [UIPickerView new];
    savPiker.tag = 200;
    savPiker.delegate = self;
    savPiker.dataSource =self;
    
    [_savView addSubview:savPiker];
    
    [savPiker zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.heightValue(screenheight/4).widthValue(_savView.frame.size.width/2).topSpace(screenheight/12)
        .leftSpace(_savView.frame.size.width/4);
    }];
    
    //添加tap手势
    UITapGestureRecognizer* savtap  = [UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        
    }];
    savtap.delegate =self;
    [_savView addGestureRecognizer:savtap];
    
    [UIView animateWithDuration:0.4 animations:^{
        _savView.frame = CGRectMake(20, 20, screenwith-40, _maskView.frame.size.height-200);
        
    }];
    
    
}
#pragma mark - 经验
-(void)initExpView{
    _maskView.hidden = NO;
    
    _expView = [[UIView alloc]initWithFrame:CGRectMake(20, -300, screenwith-40, _maskView.frame.size.height-200)] ;
    [_maskView addSubview:_expView];
    
    _expView.backgroundColor = [UIColor whiteColor];
    
    UIButton* removebtn = [UIButton createButtonWithFrame:CGRectMake(10, 10, 20, 20) Target:self Selector:@selector(removeBtnPress:) Image:@"quit_art_normal" ImagePressed:@"quit_art_pressed"];
    [_expView addSubview:removebtn];
    
    UIButton* confirmbtn = [UIButton createButtonWithFrame:CGRectZero Title:@"确定" Target:self Selector:@selector(confirmbtnPress:)];
    confirmbtn.backgroundColor = [UIColor colorWithRed:0.109 green:0.849 blue:0.984 alpha:1.000];
    [confirmbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
 
    
    [_expView addSubview:confirmbtn];
    [confirmbtn zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.bottomSpace(20);
        layout.heightValue(30);
        layout.widthValue(80);
        layout.leftSpace(_expView.frame.size.width/2-40);
        
    }];
    //薪金范围
    _expArr = [NSArray arrayWithObjects:@"应届生",@"1-3年",@"3-5年",@"5-10年",@"10年以上" ,nil];
    _expRange = _expArr[0];
    //选择器
    UIPickerView* expPicker = [UIPickerView new];
    expPicker.tag =201;
    expPicker.delegate = self;
    expPicker.dataSource =self;
    
    [_expView addSubview:expPicker];
    
    [expPicker zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.heightValue(screenheight/4).widthValue(_expView.frame.size.width/2).topSpace(screenheight/12)
        .leftSpace(_expView.frame.size.width/4);
    }];
    
    //添加tap手势
    UITapGestureRecognizer* savtap  = [UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        
    }];
    savtap.delegate =self;
    [_expView addGestureRecognizer:savtap];
    
    [UIView animateWithDuration:0.4 animations:^{
        _expView.frame = CGRectMake(20, 20, screenwith-40, _maskView.frame.size.height-200);
        
    }];

    
    
}
#pragma mark - 公司类型
-(void)initCorView{
    
}

-(void)removeBtnPress:(UIButton*)sender{
    _maskView.hidden = YES;
    _salarybtn.selected =NO;
    self.tableView.scrollEnabled=YES;
}

#pragma mark - 确认按钮 确认后退出并刷新页面
-(void)confirmbtnPress:(UIButton*)sender{
    _maskView.hidden = YES;
    _salarybtn.selected =NO;
    _exprebtn.selected =NO;
    _corBtn.selected =NO;
    self.tableView.scrollEnabled=YES;
    
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(pickerView.tag ==200){
        return   [_savArr count];

    }else if(pickerView.tag == 201){
        return   [_expArr count];

    }else
        return  0;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(pickerView.tag ==200){
        return   _savArr[row];;
        
    }else if(pickerView.tag == 201){
        return  _expArr[row];
        
    }else
        return  @"";
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView.tag ==200){
        NSLog(@"选中薪水区间:%@",_savArr[row]);
        _savRange = _savArr[row];
    }else if(pickerView.tag == 201){
        NSLog(@"选中经验区间:%@",_expArr[row]);
        _expRange = _expArr[row];
        
    }
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    _maskView.hidden = YES;
//    _salarybtn.selected = NO;

}
@end
