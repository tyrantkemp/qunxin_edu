//
//  VipViewController.m
//  qunxin_edu
//
//  Created by 肖准 on 6/28/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "VipViewController.h"
#import "dinnerTableViewCell.h"
#import "paywayTableViewCell.h"

static NSString* cellId1 = @"dinnerTableViewCell_id";
static NSString* cellId2 = @"paywayTableViewCell_id";


@interface VipViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView* _tableview;
    NSInteger _dinnercheckindex;
    NSInteger _paycheckindex;
}

@end

@implementation VipViewController

-(instancetype)init{
    self = [super init];
    if(self){
        
        _dinnercheckindex = 1;
        _paycheckindex = 1;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //tableview 不扩展 只在bar和navigation之间显示 默认UIRectEdgeAll
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {self.edgesForExtendedLayout= UIRectEdgeNone;
    }
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.937 alpha:1.000]];
    
    
    
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenwith, screenheight-44-64) style:UITableViewStyleGrouped];
    
    _tableview.delegate = self;
    _tableview.dataSource =self;
    [_tableview setBackgroundColor:[UIColor colorWithWhite:0.937 alpha:1.000]];
    
    
    //cellid 注册
    [_tableview registerClass:[dinnerTableViewCell class] forCellReuseIdentifier:cellId1];
  //  [_tableview registerClass:[paywayTableViewCell class] forCellReuseIdentifier:cellId2];

    
    [self.view addSubview:_tableview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - tableview delegate 

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        return 3;
    }else if(section == 1){
        return 3;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section ==1){
        return 44;
    }else
    return .1;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section==1) {
        UIView * foot = [UIView new];
        [foot setFrame:CGRectMake(0, 0, screenwith, 50)];
        foot.backgroundColor=[UIColor colorWithWhite:0.937 alpha:1.000];
        
        UIButton* subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [subBtn setTitle:@"开 通" forState:UIControlStateNormal];
        [subBtn setBackgroundColor:[UIColor colorWithRed:0.996 green:0.792 blue:0.086 alpha:1.000]];
        
        [subBtn addTarget:self action:@selector(submitBtn:) forControlEvents:UIControlEventTouchUpInside];
        [subBtn setFrame:CGRectMake(10, 5, screenwith-20, 40)];
        [foot addSubview:subBtn];
        
        
        
        return foot;
    }
    
    return nil;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section==0) {
        
        
        
        if(row == 0){
           
            UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"vip_dinner_cell"];
            cell.textLabel.text = @"会员套餐";
            [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14]];
            [cell.textLabel setTextColor:[UIColor blackColor]];
            [cell setBackgroundColor:[UIColor whiteColor]];
            cell.userInteractionEnabled = NO;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }else if(row == 1){
            
            NSString* str = @"月度会员 30 元";
            NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:str];
            [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, str.length-1)];
            [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.996 green:0.792 blue:0.086 alpha:1.000] range:[str rangeOfString:@"30"]];
            

            
            UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"vip_dinner_cell_month"];
            [cell.textLabel setAttributedText:attr];
            [cell setBackgroundColor:[UIColor whiteColor]];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            return cell;
        }else if(row ==2 ){
            
            NSString* str = @"年度会员 260 元";
            NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:str];
            [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, str.length-1)];
            [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.996 green:0.792 blue:0.086 alpha:1.000] range:[str rangeOfString:@"260"]];

            
            
            UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"vip_dinner_cell_year"];
            [cell.textLabel setAttributedText:attr];
            [cell setBackgroundColor:[UIColor whiteColor]];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }
        
    }else if(section == 1){
        if(row == 0){
            UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"pay_way_cell"];
            cell.textLabel.text = @"支付方式";
            [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14]];
            [cell.textLabel setTextColor:[UIColor blackColor]];
            [cell setBackgroundColor:[UIColor whiteColor]];

            cell.userInteractionEnabled = NO;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }else if(row == 1){
            UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"pay_way_cell_we"];
            cell.textLabel.text = @"微信支付";
            [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
            [cell.textLabel setTextColor:[UIColor blackColor]];
            [cell setBackgroundColor:[UIColor whiteColor]];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            return cell;
            
            
            
        }else if(row ==2){
            UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"pay_way_cell_zhifu1"];
            cell.textLabel.text = @"支付宝";
            [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
            [cell.textLabel setTextColor:[UIColor blackColor]];
            [cell setBackgroundColor:[UIColor whiteColor]];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            return cell;
            
            
        }
        
    }
    
    
    return nil;
    
    
    
    
}


-(UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{
    
    
    if(indexPath.row==0){
        return UITableViewCellAccessoryNone;
    }
    
    if(indexPath.section==0){
    if(_dinnercheckindex==indexPath.row)
    {
        return UITableViewCellAccessoryCheckmark;
    }
    else
    {
        return UITableViewCellAccessoryNone;
    }
    
    }else {
        
        if(_paycheckindex==indexPath.row)
        {
            return UITableViewCellAccessoryCheckmark;
        }
        else
        {
            return UITableViewCellAccessoryNone;
        }
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section =indexPath.section;
    
    
    if(section ==0 ){


        _dinnercheckindex =indexPath.row;
        [_tableview reloadData];
        
    }else if(section == 1){
        
        _paycheckindex = indexPath.row;
        [_tableview reloadData];
    }
    
    
}


#pragma mark - 开通
-(void)submitBtn:(UIButton*)sender{
    NSLog(@"开通会员 套餐:%d  支付方式:%d",_dinnercheckindex,_paycheckindex);
    
    
    //判断是否登陆
    
    
    
    
    
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
