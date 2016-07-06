//
//  CorInfoViewController.m
//  qunxin_edu
//
//  Created by 肖准 on 6/11/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "CorInfoViewController.h"
#import "Job.h"
#import "corHeaderView.h"
#import "CorInfoTableViewCell.h"
static NSString * cellId = @"corporationinfocell";

@interface CorInfoViewController ()

@end

@implementation CorInfoViewController

-(instancetype)init{
    self = [super init];
    
    if(self){
        self.hidesBottomBarWhenPushed = YES;

        __weak CorInfoViewController * corinfoCtl = self;
        corinfoCtl.generateURL = ^NSString*(NSUInteger page){
        
            NSString* url = [NSString stringWithFormat:@"%@%@?pageIndex=%lu&%@", MAIN_PREFIX, MAIN_CORPORATION, (unsigned long)page, MAIN_SUFFIX];

            NSLog(@"获取具体公司信息url:%@",url);
            return url;
        };
        
        self.tableWillReload = ^(NSUInteger count){
            (count<20)?(corinfoCtl.lastCell.status = LastCellStatusFinished):(corinfoCtl.lastCell.status = LastCellStatusMore);
            
        };
        
        self.objClass = [CorInfoViewController class];
        self.needCache = YES;
        self.needAutoRefresh = NO;
        
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[CorInfoTableViewCell class] forCellReuseIdentifier:cellId];
    UIImageView * icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"corporation_default"]];
    
    NSString* corintro =@"百度（Nasdaq：BIDU）是全球最大的中文搜索引擎、最大的中文网站。2000年1月由李彦宏创立于北京中关村，致力于向人们提供“简单，可依赖”的信息获取方式。“百度”二字源于中国宋朝词人辛弃疾的《青玉案·元夕》词句“众里寻他千百度”，象征着百度对中文信息检索技术的执著追求。2015年1月24日，百度创始人、董事长兼CEO李彦宏在百度2014年会暨十五周年庆典上发表的主题演讲中表示，十五年来，百度坚持相信技术的力量，始终把简单可依赖的文化和人才成长机制当成最宝贵的财富，他号召百度全体员工，向连接人与服务的战略目标发起进攻[1]  。2015年11月18日，百度与中信银行发起设立百信银行。";
    
    corHeaderView * headerview = [[corHeaderView alloc]initWithCorInfo:icon corname:@"百度" numRange:@"400-5000" corType:@"互联网" corIntro:corintro];
        
    [headerview setFrame:CGRectMake(0, 0, self.view.frame.size.width, headerview.height)];
    self.tableView.tableHeaderView = headerview;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIImageView * icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"corporation_default"]];
//    
//    corHeaderView * headerview = [[corHeaderView alloc]initWithCorInfo:icon corname:@"百度" numRange:@"400-5000" corType:@"互联网" corIntro:@"百度（Nasdaq：BIDU）是全球最大的中文搜索引擎、最大的中文网站。2000年1月由李彦宏创立于北京中关村，致力于向人们提供“简单，可依赖”的信息获取方式。“百度”二字源于中国宋朝词人辛弃疾的《青玉案·元夕》词句“众里寻他千百度”，象征着百度对中文信息检索技术的执著追求。2015年1月24日，百度创始人、董事长兼CEO李彦宏在百度2014年会暨十五周年庆典上发表的主题演讲中表示，十五年来，百度坚持相信技术的力量，始终把简单可依赖的文化和人才成长机制当成最宝贵的财富，他号召百度全体员工，向连接人与服务的战略目标发起进攻[1]  。2015年11月18日，百度与中信银行发起设立百信银行。"];
//    
//    return headerview;
//    
//}
//-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 300;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CorInfoTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    //CorInfo * corinfo = self.objects[indexPath.row];
//    @property(nonatomic,strong)UILabel* jobindexLabel;
//    @property(nonatomic,strong)UILabel* salaryLabel;
//    @property(nonatomic,strong)UIImageView* cityImgView;
//    @property(nonatomic,strong)UILabel* subInfoLabel;  //city 工作年限  学历
//    
//    @property(nonatomic,strong)UIImageView* corIconImgView;
//    
//    @property(nonatomic,strong)UILabel* jobNameLabel;
//    @property(nonatomic,strong)UILabel* corNameLabel;
//    @property(nonatomic,strong)UILabel* updateLabel;
//    
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
@end
