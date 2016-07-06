//
//  dinnerTableViewCell.m
//  qunxin_edu
//
//  Created by 肖准 on 6/29/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "dinnerTableViewCell.h"

@interface dinnerTableViewCell(){
    
    UILabel* _titleLB;
    UILabel* _subtitleLB;
    
    UIButton* _checkBtn;
    CGFloat _height;
    
    NSAttributedString* _titletext ;
    NSAttributedString* _subtitletext;
}

@end


@implementation dinnerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(instancetype)initWithStyleAndTitleAndSubTitle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier title:(NSMutableAttributedString*)attribuestring subtitle:(NSMutableAttributedString*)subtitle height:(CGFloat)height{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        _isChecked = NO;
        _height = height;
        _titletext = attribuestring;
        _subtitletext = subtitle;
        [self inisubviews];
        [self setlayouts];
        
        
    }
    return self;
    
    
    
}
-(void)inisubviews{
    
    _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_checkBtn setBackgroundImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
    [_checkBtn setBackgroundImage:[UIImage imageNamed:@"checkbox_checked"] forState:UIControlStateSelected];
    
    [_checkBtn addTarget:self action:@selector(press:) forControlEvents:UIControlEventTouchUpInside];
   
    [self.contentView addSubview:_checkBtn];
    
    //主title
    _titleLB = [UILabel new];
    [_titleLB setAttributedText:_titletext];
    [self.contentView addSubview:_titleLB];
    
    //副title
    _subtitleLB = [UILabel new];
    [_subtitleLB setAttributedText:_subtitletext];
    [self.contentView addSubview:_subtitleLB];
    
    
    
}


-(void)setlayouts{
    
    
    [_checkBtn zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.topSpace(10).bottomSpace(10).rightSpace(5).heightValue(_height-20).widthValue(_height-20);
    }];
    
    
    [_subtitleLB zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.rightSpaceByView(_checkBtn,5).topSpace(5).bottomSpace(5);
    }];
    
    [_titleLB zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpace(15).topSpace(5).bottomSpace(5);
    }];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setIsChecked:(BOOL)isChecked{
        _checkBtn.selected = isChecked;
    
}
-(void)press:(UIButton*)sender{
    if(sender.selected == NO){
        _isChecked = YES;
        sender.selected = YES;
    }else {
        _isChecked = NO;
        sender.selected =NO;
    }
    if(_checkpress){
        _checkpress(sender);
    }
    NSLog(@"套餐计划check");
}
@end
