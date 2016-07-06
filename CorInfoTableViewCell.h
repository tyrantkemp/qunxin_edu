//
//  CorInfoTableViewCell.h
//  qunxin_edu
//
//  Created by 肖准 on 6/11/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CorInfoTableViewCell : UITableViewCell


//@property(nonatomic,strong) NSString* jobIndex;
//@property(nonatomic,assign) NSUInteger bottomSalery;
//@property(nonatomic,assign) NSUInteger topSalery;
//@property(nonatomic,strong) UIImageView* localImage;
//@property(nonatomic,strong) NSString* localCity;
//@property(nonatomic,assign) NSUInteger bottomYear;
//@property(nonatomic,assign) NSUInteger topYear;
//@property(nonatomic,strong) NSString* degree;
//
//@property(nonatomic,strong)UIImageView* corIcon;
//@property(nonatomic,strong)NSString* jobName;
//@property(nonatomic,strong)NSString* corName;
//
//@property(nonatomic,strong)NSDate* updateTime;

@property(nonatomic,strong)UILabel* jobindexLabel;
@property(nonatomic,strong)UILabel* salaryLabel;
@property(nonatomic,strong)UIImageView* cityImgView;
@property(nonatomic,strong)UILabel* subInfoLabel;  //city 工作年限  学历

@property(nonatomic,strong)UIImageView* corIconImgView;

@property(nonatomic,strong)UILabel* jobNameLabel;
@property(nonatomic,strong)UILabel* corNameLabel;
@property(nonatomic,strong)UILabel* updateLabel;



@end
