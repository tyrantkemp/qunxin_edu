//
//  courseView.m
//  qunxin_edu
//
//  Created by 肖准 on 6/21/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "courseView.h"
#import "UIImageView+WebCache.h"

@interface courseView()<UIGestureRecognizerDelegate>{
    UIView* _bacview;
    UIImageView* _courseThumbnail;
    UILabel* _courseIntroLB;
    UILabel* _courseTimeLB;
    UILabel* _learnerNumLB;
    CGFloat _height ;
   // Course* _tapcourse;

    courseMJ* _tapcourse;
}
@end
@implementation courseView


-(instancetype)initWithCourseInfoAndHeight:(courseMJ*) course height:(CGFloat)height{
    
    
    if([super init]){
        _height = height;
        _tapcourse = course;
        [self initsubviews];
        [self setlayout];
        
    }
    return  self;
    
    
}

-(void)initsubviews{
    
    
    //背景视图
    _bacview = [UIView new];
    [self addSubview:_bacview];
    
    //课程缩略图
    _courseThumbnail = [UIImageView new];
    [_courseThumbnail setContentMode:UIViewContentModeScaleToFill];
    [_bacview addSubview:_courseThumbnail];
    
    //课程简介
    _courseIntroLB = [UILabel new];
    [_courseIntroLB setText:_tapcourse.title];
    [_courseIntroLB setFont:[UIFont systemFontOfSize:12]];
    _courseIntroLB.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
    
    [_courseIntroLB setTextColor:[UIColor grayColor]];
    [_courseIntroLB setNumberOfLines:1];

    [_bacview addSubview:_courseIntroLB];
    
    //课程时长
    _courseTimeLB = [UILabel new];
    [_courseTimeLB setText:@"21小时"];
    [_courseTimeLB setLineBreakMode:NSLineBreakByWordWrapping];
    [_courseTimeLB setFont:[UIFont systemFontOfSize:10]];
    [_courseTimeLB setTextColor:[UIColor grayColor]];
    [_bacview addSubview:_courseTimeLB];
    
    //学习人数
    _learnerNumLB = [UILabel new];
    [_learnerNumLB setText:[NSString stringWithFormat:@"%d人学习",_tapcourse.learnerNum]];
    [_learnerNumLB setLineBreakMode:NSLineBreakByWordWrapping];
    [_learnerNumLB setFont:[UIFont systemFontOfSize:10]];
    [_learnerNumLB setTextColor:[UIColor grayColor]];
    [_bacview addSubview:_learnerNumLB];
    
    
    //添加tap手势
    _bacview.userInteractionEnabled=YES;
    UITapGestureRecognizer* tap = [UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        NSLog(@"课程点击");
        
        if(_courseTap){
            _courseTap(@"点击课程的url");
        }
        
        
    }];
    [_bacview addGestureRecognizer:tap];

    tap.delegate = self;
    
    
}




-(void)setlayout{
    
    [_bacview zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpace(2).rightSpace(0).topSpace(2).heightValue(_height-2);
        
    }];
    
    [_courseThumbnail sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,_tapcourse.picUrl]] placeholderImage:[UIImage imageNamed:@"a01"]];
   

    [_courseThumbnail zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.topSpace(0).leftSpace(0).rightSpace(0).heightValue(_height/7*5-8);
        
    }];
    
    [_courseIntroLB zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.topSpaceByView(_courseThumbnail,4).leftSpace(0).rightSpace(0).widthValue(screenwith/5*2);
    }];
    
    [_courseTimeLB zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.topSpaceByView(_courseIntroLB,2).leftSpace(0).bottomSpace(2).topSpaceByView(_courseIntroLB,2);
        
    }];
    
    [_learnerNumLB zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.topSpaceEqualTo(_courseTimeLB,0 ).rightSpace(1).bottomSpace(2).topSpaceEqualTo(_courseTimeLB,0);
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
