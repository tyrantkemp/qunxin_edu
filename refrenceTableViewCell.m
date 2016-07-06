//
//  refrenceTableViewCell.m
//  qunxin_edu
//
//  Created by 肖准 on 6/24/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "refrenceTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface refrenceTableViewCell(){
    Course* _course;
    CGFloat _cellHeight;
}
@end
@implementation refrenceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier course:(Course*)course cellheight:(CGFloat)height;{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
    
        _course = course;
        _cellHeight = height;
        [self initsubviews];
        [self setlayouts];
        
    }
    return  self;
    
}


-(void)initsubviews{
    
    _courseThumbnail = [UIImageView new];
    [_courseThumbnail setContentMode:UIViewContentModeScaleToFill];
    [_courseThumbnail sd_setImageWithURL:[NSURL URLWithString:@"http://139.196.21.175:18080/upload/android_1.jpg"] placeholderImage:[UIImage imageNamed:@"a01"]];
    [self.contentView addSubview:_courseThumbnail];
    
    
    _courseNameLB = [UILabel new];
    [_courseNameLB setFont:[UIFont systemFontOfSize:13]];
    _courseNameLB.numberOfLines =1;
    [_courseNameLB setText:@"ios开发animation详细讲解"];
    [  _courseNameLB setLineBreakMode:NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail ];
    [self.contentView addSubview:_courseNameLB];
    
    CGSize namesize = [_courseNameLB.text boundingRectWithSize:CGSizeMake(screenwith, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_courseNameLB.font} context:nil].size;
    
    
    
    _timeicon = [UIImageView new];
    [_timeicon setImage:[UIImage imageNamed:@"time"]];
    //[_timeicon setBounds:CGRectMake(0, 0, namesize.height, namesize.height)];
    NSLog(@"width:%f",namesize.height);
    [self.contentView addSubview:_timeicon];
    
    
    
    
    _courseTimeLB = [UILabel new];
    [_courseTimeLB setFont:[UIFont systemFontOfSize:12]];
    [_courseTimeLB setTextColor:[UIColor grayColor]];
    [_courseTimeLB setText:@"3课时,154分钟"];
    [self.contentView addSubview:_courseTimeLB];
    
    
}

-(void)setlayouts{
    CGSize namesize = [_courseNameLB.text boundingRectWithSize:CGSizeMake(screenwith, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_courseNameLB.font} context:nil].size;
    [_courseThumbnail zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
       
        layout.topSpace(0).leftSpace(0).bottomSpace(0).heightValue(_cellHeight).widthValue(screenwith/3);
        
    }];
    
    [_courseNameLB zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpaceByView(_courseThumbnail,10).topSpace((_cellHeight-5)/3);
    }];
    
    [_timeicon zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.topSpaceByView(_courseNameLB,10).leftSpaceByView(_courseThumbnail,10).widthValue(namesize.height).heightValue(namesize.height);
    }];
    
    [_courseTimeLB zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpaceByView(_timeicon,5).topSpaceEqualTo(_timeicon,0);
    }];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
