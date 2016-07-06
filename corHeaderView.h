//
//  corHeaderView.h
//  qunxin_edu
//
//  Created by 肖准 on 6/12/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Corporation.h"
@interface corHeaderView : UIView

@property(nonatomic,strong) UIImageView* corIcon;
@property(nonatomic,strong) UILabel* corNameLB;
@property(nonatomic,strong) UILabel* emplyeeNumLB;
@property(nonatomic,strong) UILabel* corTypeLB;
@property(nonatomic,strong) UILabel* corIntroLB;

@property(nonatomic,strong) UILabel* corRangeTitle;
@property(nonatomic,strong) UILabel* corTypeTitle;


@property(assign,nonatomic) CGFloat height;

-(instancetype)initWithCorInfo:(UIImageView*)icon corname:(NSString*)corname numRange:(NSString*)numRange
                       corType:(NSString*)corType corIntro:(NSString*)corIntro;

-(instancetype)initWithCorInfo:(Corporation*)  corporation;

@end
