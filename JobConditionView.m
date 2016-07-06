//
//  JobConditionView.m
//  qunxin_edu
//
//  Created by 肖准 on 6/13/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "JobConditionView.h"
#import "UIButton+create.h"
#import "UIView+Util.h"
@interface JobConditionView()<UIGestureRecognizerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
 
    UIView *_maskView;

    UIView *_savView;
    UIPickerView* _picker;
    NSArray* _savArr;
    
    
    UIView *_expView;
    UIView *_corView;
    
}

@end
@implementation JobConditionView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        [self createviews];

        
    }
    return self;
}


-(void)createviews{

    
    UIButton *salarybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [salarybtn setFrame:CGRectMake(0, 0, screenwith/3, self.frame.size.height)];
    [salarybtn setTitle:@"薪金" forState:UIControlStateNormal];
    [salarybtn addTarget:self action:@selector(salarybtnPress:) forControlEvents:UIControlEventTouchUpInside];
    
//    UIButton* salarybtn = [UIButton createButtonWithFrame:CGRectMake(0, 0,screenwith/3 , self.frame.size.height) Title:@"薪金" Target:self Selector:@selector(salarybtnPress:)];
    [salarybtn setTitleColor:[UIColor colorWithRed:0.128 green:0.883 blue:0.526 alpha:1.000] forState:UIControlStateSelected];
    [salarybtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    [self addSubview:salarybtn];
    
    
    UIButton* exprebtn = [UIButton createButtonWithFrame:CGRectMake(screenwith/3, 0,screenwith/3 , self.frame.size.height) Title:@"经验" Target:self Selector:@selector(exprebtnPress:)];
    [exprebtn setTitleColor:[UIColor colorWithRed:0.128 green:0.883 blue:0.526 alpha:1.000] forState:UIControlStateSelected];
    [self addSubview:exprebtn];
    
    UIButton* corbtn = [UIButton createButtonWithFrame:CGRectMake(screenwith/3*2, 0,screenwith/3 , self.frame.size.height) Title:@"公司类型" Target:self Selector:@selector(corbtnPress:)];
    [corbtn setTitleColor:[UIColor colorWithRed:0.128 green:0.883 blue:0.526 alpha:1.000] forState:UIControlStateSelected];
    [self addSubview:corbtn];
    
    
    [self initMask];
    
    
    
}

-(void)salarybtnPress:(UIButton*) btn{
    
    if(btn.selected == NO){
        [self initSavView];
        btn.selected = YES;
    }else {
        _maskView.hidden =YES;
        [_savView removeFromSuperview];
        btn.selected = NO;

    }

    
}
-(void)exprebtnPress:(UIButton*) btn{
    
    
}
-(void)corbtnPress:(UIButton*) btn{
    
    
}

#pragma  mark - 遮盖层
-(void)initMask{
    
    _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, screenwith, screenheight-64-40)];
    _maskView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.352];
    
    [self addSubview:_maskView];
    _maskView.hidden = YES;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMaskView:)];
    tap.delegate = self;
    [_maskView addGestureRecognizer:tap];
    

}

-(void)tapMaskView:(UITapGestureRecognizer*) sender{
    _maskView.hidden = YES;
}

#pragma mark - 薪水

-(void)initSavView{
    
    
    
    _maskView.hidden = NO;
    [self bringSubviewToFront:_maskView];
    
    _savView = [[UIView alloc]initWithFrame:CGRectMake(20, -300, screenwith-40, _maskView.frame.size.height-140)] ;
    [_maskView addSubview:_savView];

    _savView.backgroundColor = [UIColor whiteColor];
    
    UIButton* removebtn = [UIButton createButtonWithFrame:CGRectMake(10, 10, 20, 20) Target:self Selector:@selector(removeBtnPress:) Image:@"quit_art_normal" ImagePressed:@"quit_art_pressed"];
    [_savView addSubview:removebtn];

    UIButton* confirmbtn = [UIButton createButtonWithFrame:CGRectZero Title:@"确定" Target:self Selector:@selector(confirmbtnPress:)];
    confirmbtn.backgroundColor = [UIColor colorWithRed:0.109 green:0.849 blue:0.984 alpha:1.000];
    
    [_savView addSubview:confirmbtn];
    [confirmbtn zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.bottomSpace(20);
        layout.heightValue(30);
        layout.widthValue(80);
        layout.leftSpace(_savView.frame.size.width/2-40);
        
    }];
    //薪金范围
    _savArr = [NSArray arrayWithObjects:@"3k-4k",@"4k-5k",@"5k-6k",@"6k-7k",@"7k-10k",@"10k-15k" ,nil];
    
    //选择器
    _picker = [UIPickerView new];
    _picker.delegate = self;
    _picker.dataSource =self;
    
    [_savView addSubview:_picker];
    
    [_picker zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.heightValue(screenheight/4).widthValue(_savView.frame.size.width/2).topSpace(screenheight/8)
        .leftSpace(_savView.frame.size.width/4);
    }];
    
    
    [UIView animateWithDuration:0.4 animations:^{
        _savView.frame = CGRectMake(20, 20, screenwith-40, _maskView.frame.size.height-140);

    }];
   

    
    
}
-(void)removeBtnPress:(UIButton*)sender{
    
}
-(void)confirmbtnPress:(UIButton*)sender{
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
  return   [_savArr count];
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _savArr[row];

}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    
}
@end
