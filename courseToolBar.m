//
//  courseToolBar.m
//  qunxin_edu
//
//  Created by 肖准 on 6/26/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "courseToolBar.h"

@implementation courseToolBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addsubviews];
        [self setlayouts];
        _isStared = NO;
        
    }
    return self;
}


-(void)addsubviews{
    
    //收藏
    _starBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_starBtn setImage:[UIImage imageNamed:@"star_normal"] forState:UIControlStateNormal];
    //[_starBtn setImage:[UIImage imageNamed:@"star_pressed"] forState:UIControlStateSelected];
    
    [_starBtn addTarget:self action:@selector(starPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_starBtn];
    
    //分享
    _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shareBtn setImage:[UIImage imageNamed:@"share-1"] forState:UIControlStateNormal];
    [_shareBtn addTarget:self action:@selector(sharePressed:) forControlEvents:UIControlEventTouchUpInside];
    _shareBtn.adjustsImageWhenHighlighted = NO;
    [self addSubview:_shareBtn];
    
    //上一个
    _preBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [_preBtn setImage:[UIImage imageNamed:@"previous_1"] forState:UIControlStateNormal];
    [_shareBtn addTarget:self action:@selector(prePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_preBtn];
    
    
    //下一个
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextBtn setImage:[UIImage imageNamed:@"next_1"] forState:UIControlStateNormal];
    [_nextBtn addTarget:self action:@selector(nextPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nextBtn];
    
    
}

-(void)setlayouts{
    CGFloat height =self.frame.size.height;
    NSLog(@"heig:%f",self.frame.size.height);
    
    [_shareBtn zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.rightSpace(10).topSpace(5).heightValue(height-10).widthValue(height-10);
        
        
    }];
    
    [_starBtn zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
       
        layout.rightSpaceByView(_shareBtn,10).topSpace(5).heightValue(height-10).widthValue(height-10);

        
    }];
    
    
    [_preBtn zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpace(10).topSpace(7).heightValue(height-14).widthValue(height-10);

    }];
    
    [_nextBtn zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
       
        layout.leftSpaceByView(_preBtn,10).topSpace(7).heightValue(height-14).widthValue(height-10);

    }];
}


-(void)starPressed:(UIButton*)sender{
    
    if(_starPressed){
        _starPressed();
    }
    
}
-(void)sharePressed:(UIButton*)sender{
    if(_sharePressed){
        _sharePressed();
    }
}

-(void)prePressed:(UIButton*)sender{
    if(_prePressed){
        _prePressed();
    }

}


-(void)nextPressed:(UIButton*)sender{
    if(_nextPressed){
        _nextPressed();
    }
    
}

-(void)setIsStared:(BOOL)isStared{
    if(isStared){
        [_starBtn setImage:[UIImage imageNamed:@"star_pressed"] forState:UIControlStateNormal];
    }else {
        [_starBtn setImage:[UIImage imageNamed:@"star_normal"] forState:UIControlStateNormal];
    }
    _isStared = isStared;
}
@end
