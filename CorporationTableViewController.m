//
//  CorporationTableViewController.m
//  qunxin_edu
//
//  Created by 肖准 on 6/5/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "CorporationTableViewController.h"
#import "corporationMJ.h"
#import "corporationcell.h"
#import "CorInfoViewController.h"

static NSString * cellId = @"corporationcell";

@interface CorporationTableViewController ()


@end

@implementation CorporationTableViewController


-(instancetype)init{
    self = [super init];
    if(self){
        
        __weak CorporationTableViewController * corpctl = self;
        
        self.generateURL = ^NSString*(NSUInteger page){
            NSString* url =[NSString stringWithFormat:@"%@%@%@?pageIndex=%lu&%@", MAIN, MAIN_CORPORATION,GET_CORP, (unsigned long)page, MAIN_SUFFIX];
            NSLog(@"url:%@",url);
           return url;
            
        };
        
        self.tableWillReload = ^(NSUInteger count){
            ((count < 20)?(corpctl.lastCell.status =LastCellStatusFinished):(corpctl.lastCell.status = LastCellStatusMore));
        };
        
        self.objClass = [corporationMJ class];
        
        self.needAutoRefresh = YES;
        self.refreshInterval = 21600;
        self.kLastRefreshTime = @"CorporationRefreshInterval";
        
    }
    
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册cell
   // [self.tableView registerClass:[corporationcell class] forCellReuseIdentifier:cellId];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    
    corporationMJ* cor = self.objects[indexPath.row];
    cell.textLabel.text = cor.corName;
    [cell.imageView loadPortrait:[NSURL URLWithString:cor.iconUrl]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@:%d",@"热招岗位数",cor.jobNumber];
    
    
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame ];
    cell.selectedBackgroundView.backgroundColor = [UIColor selectCellSColor];
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CorInfoViewController* corinfo = [[CorInfoViewController alloc]init];
    [self.navigationController pushViewController:corinfo animated:YES];
    
    
    
}


-(NSArray*)parseJson:(id)responseObject{
    NSArray *jsonarr = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];

    NSArray* res =[corporationMJ mj_objectArrayWithKeyValuesArray:jsonarr];
    
  // NSArray * arr = responseObject;
   //NSArray *arr =  [NSKeyedUnarchiver unarchiveObjectWithData:responseObject];
//    RLMRealm * reaml =[RLMRealm defaultRealm];
//    [reaml beginWriteTransaction];
//    NSArray* res = [Corporation createOrUpdateInRealm:reaml withJSONArray:json];
//    [reaml commitWriteTransaction];
//    NSLog(@"公司：%@",res);
//    return res;
//    

    return res;
}

@end
