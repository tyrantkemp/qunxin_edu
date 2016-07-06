//
//  refrenceTableViewCell.h
//  qunxin_edu
//
//  Created by 肖准 on 6/24/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SWTableViewCell.h>

#import "Course.h"

@interface refrenceTableViewCell : SWTableViewCell

@property(nonatomic,strong)UIImageView* courseThumbnail;
@property(nonatomic,strong)UILabel* courseNameLB;
@property(nonatomic,strong)UILabel* courseTimeLB;

@property(nonatomic,strong)UIImageView* timeicon;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier course:(Course*)course cellheight:(CGFloat)height;
@end
