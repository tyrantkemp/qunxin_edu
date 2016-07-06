//
//  CorInfoTableViewCell.m
//  qunxin_edu
//
//  Created by 肖准 on 6/11/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "CorInfoTableViewCell.h"
@implementation CorInfoTableViewCell



-(instancetype )initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        [self initSubviews];
        [self setlayout];
        
        
    }
    
    return self;
}

-(void)initSubviews{
    
    
//    @property(nonatomic,strong)UILabel* jobindexLabel;
    self.jobindexLabel = [UILabel new];
    self.jobindexLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.jobindexLabel.numberOfLines = 0;
    self.jobindexLabel.font = [UIFont boldSystemFontOfSize:17];
    self.jobindexLabel.textColor = [UIColor colorWithRed:0.121 green:0.886 blue:0.921 alpha:1.000];
    [self.contentView addSubview:self.jobindexLabel];
    
    
    
//    @property(nonatomic,strong)UILabel* salaryLabel;
    self.salaryLabel =[ UILabel new];
    self.salaryLabel.numberOfLines = 0;
    self.salaryLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.salaryLabel.font = [UIFont systemFontOfSize:13];
    self.salaryLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:self.salaryLabel];
    
    
    // @property(nonatomic,strong)UIImageView* cityImgView;
    self.cityImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"local"]];
    [self.contentView addSubview:self.cityImgView];
    
    
    
//    @property(nonatomic,strong)UILabel* subInfoLabel;  //city 工作年限  学历
    self.subInfoLabel = [UILabel new];
    self.subInfoLabel.numberOfLines = 0;
    self.subInfoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.subInfoLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.subInfoLabel];
    
    
//    @property(nonatomic,strong)UIImageView* corIconImgView;

    self.corIconImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_uc_normal"]];
    [self.contentView addSubview:self.corIconImgView];
    
//    @property(nonatomic,strong)UILabel* jobNameLabel;
    self.jobNameLabel = [UILabel new];
    self.jobNameLabel.numberOfLines = 0;
    self.jobNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.jobNameLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:self.jobNameLabel ];
    
    
    
//    @property(nonatomic,strong)UILabel* corNameLabel;
    self.corNameLabel = [UILabel new];
    self.corNameLabel .numberOfLines = 0;
    self.corNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.corNameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.corNameLabel];
    
//    @property(nonatomic,strong)UILabel* updateLabel;
    self.updateLabel = [UILabel new];
    self.updateLabel.numberOfLines =0;
    self.updateLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.updateLabel.font = [UIFont systemFontOfSize:13];
    self.updateLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.updateLabel];
    
}


-(void)setlayout{
    [self.jobindexLabel zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.topSpace(1);
        layout.leftSpace(1);
    
    }];

    [self.salaryLabel zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.topSpaceByView(self.jobindexLabel,8);
        layout.leftSpace(20);
        
    }];
    
    [self.cityImgView zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpaceByView(self.salaryLabel,10);
        layout.topSpaceByView(self.jobindexLabel,8);
        layout.heightValue(10);
        layout.widthValue(10);
    }];
    
    [self.subInfoLabel zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpaceByView(self.cityImgView,10);
        layout.topSpaceByView(self.jobindexLabel,8);

        
    }];
    
    [self.corIconImgView zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        
        layout.topSpaceByView(self.salaryLabel,10);
        layout.leftSpace(20);
        layout.widthValue(20).heightValue(20);
        
        
    }];
    
    [self.jobNameLabel zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpaceByView(self.corIconImgView,30);
        layout.topSpaceByView(self.salaryLabel,10);

        
    }];
    
    [self.corNameLabel zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpaceByView(self.jobNameLabel,20);
        layout.topSpaceByView(self.salaryLabel,10);

    }];
    [self.updateLabel zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.bottomSpace(8);
        layout.rightSpace(10);
        
    }];
    
    
}

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
