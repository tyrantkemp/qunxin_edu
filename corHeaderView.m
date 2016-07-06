//
//  corHeaderView.m
//  qunxin_edu
//
//  Created by 肖准 on 6/12/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "corHeaderView.h"
#import "ZXPAutoLayout.h"
@implementation corHeaderView


-(instancetype)initWithCorInfo:(Corporation*)  corporation{
    
    self = [super init];
    if(self){
        
        
    }
    return self;
    
}
-(instancetype)initWithCorInfo:(UIImageView*)icon corname:(NSString*)corname numRange:(NSString*)numRange
                       corType:(NSString*)corType corIntro:(NSString*)corIntro{
    
    self = [super init];
    if(self){
        
        self.corIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"corporation_default"]];
        [self addSubview:self.corIcon];
        
        //公司名
        self.corNameLB = [UILabel new ];
        self.corNameLB .textColor = [UIColor orangeColor];
        self.corNameLB .font = [UIFont boldSystemFontOfSize:17];
        self.corNameLB .lineBreakMode = NSLineBreakByWordWrapping;
        self.corNameLB .text = corname;
        [self addSubview:self.corNameLB ];
        
        
        
        self.emplyeeNumLB = [UILabel new ];
        self.emplyeeNumLB.textColor = [UIColor orangeColor];
        self.emplyeeNumLB.font = [UIFont boldSystemFontOfSize:17];
        self.emplyeeNumLB.lineBreakMode = NSLineBreakByWordWrapping;
        self.emplyeeNumLB.text= numRange;
        [self addSubview:self.emplyeeNumLB];
        
        self.corTypeLB = [UILabel new ];
        self.corTypeLB.textColor = [UIColor orangeColor];
        self.corTypeLB.font = [UIFont boldSystemFontOfSize:17];
        self.corTypeLB.lineBreakMode = NSLineBreakByWordWrapping;
        self.corTypeLB.text = corType;
        [self addSubview:self.corTypeLB];
        
    
        
    
        CGRect rect= [corIntro boundingRectWithSize:CGSizeMake(screenwith-10,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:14]} context:nil];
        
        
        self.corIntroLB = [UILabel new];
        [self.corIntroLB setBounds:CGRectMake(0, 0, rect.size.width-10, rect.size.height)];
        self.corIntroLB.text = corIntro;
        self.corIntroLB.font = [UIFont systemFontOfSize:15];
        self.corIntroLB.numberOfLines = 0;
        [self addSubview:self.corIntroLB];
    
        self.corRangeTitle = [UILabel new ];
        self.corRangeTitle.textColor = [UIColor orangeColor];
        self.corRangeTitle.font = [UIFont boldSystemFontOfSize:17];
        self.corRangeTitle.lineBreakMode = NSLineBreakByWordWrapping;
        self.corRangeTitle.textColor = [UIColor lightGrayColor];
        self.corRangeTitle.text = @"公司规模:";
        [self addSubview:self.corRangeTitle];
        
        self.corTypeTitle = [UILabel new ];
        self.corTypeTitle.textColor = [UIColor orangeColor];
        self.corTypeTitle.font = [UIFont boldSystemFontOfSize:17];
        self.corTypeTitle.lineBreakMode = NSLineBreakByWordWrapping;
        self.corTypeTitle.textColor = [UIColor lightGrayColor];
        self.corTypeTitle.text=@"公司方向:";
        [self addSubview:self.corTypeTitle];
        
        
        self.height  = rect.size.height +170;
        [self setLayout];
        
    }
    return self;
    
}
-(void)setLayout{
    [self.corIcon zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
    
        layout.leftSpace(0);
        layout.topSpace(0);
        layout.widthValue(screenwith/3);
        layout.heightValue(screenwith/3);
        
    }];
    
    [self.corNameLB zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpaceByView(self.corIcon,10);
        layout.topSpace(20);
        
    }];
    
    [self.corRangeTitle zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpaceByView(self.corIcon,10);
        layout.topSpaceByView(self.corNameLB,5);
        
        
    }];
    [self.emplyeeNumLB zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpaceByView(self.corRangeTitle,10);
        layout.topSpaceByView(self.corNameLB,5);
        
        
    }];
    
    [self.corTypeTitle zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpaceByView(self.corIcon,10);
        layout.topSpaceByView(self.corRangeTitle,5);

    }];
    [self.corTypeLB zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpaceByView(self.corTypeTitle,10);
        layout.topSpaceByView(self.emplyeeNumLB,5);
        
        
    }];
    
    
    [self.corIntroLB zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
    
        layout.topSpaceByView(self.corIcon,10);
        
        layout.leftSpace(5);
        layout.rightSpace(5);
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
