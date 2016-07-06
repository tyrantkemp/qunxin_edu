//
//  Course2TableViewCell.h
//  qunxin_edu
//
//  Created by 肖准 on 6/21/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,courseType){
    courtseTypeHot=0,
    courseTypeNew,
    courseTypeFree
};

@interface Course2TableViewCell : UITableViewCell


@property(strong,nonatomic)UILabel* titleLB;
@property(strong,nonatomic)UIScrollView*  courseScro;


@property(strong,nonatomic)NSMutableArray* objects;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier courseArray:(NSMutableArray*)courseArr courseType:(courseType)coursetype height:(CGFloat)height;

@end
