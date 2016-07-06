//
//  Course2TableViewCell.m
//  qunxin_edu
//
//  Created by 肖准 on 6/21/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "Course2TableViewCell.h"
#import "courseView.h"
@interface Course2TableViewCell()<UIScrollViewDelegate>{
    CGFloat _titleheight;
    CGFloat _cellheight;
    NSArray* _coursearr;
}
@end

@implementation Course2TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier courseArray:(NSMutableArray*)courseArr courseType:(courseType)coursetype height:(CGFloat)height{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        NSInteger count = [courseArr count];
    
        
        _objects = [NSMutableArray new];
        _coursearr = courseArr;
        _cellheight = height;
        
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.contentView setBackgroundColor:[UIColor colorWithWhite:0.937 alpha:1.000]];
        
        //cell标题
        _titleLB = [UILabel new];
        [_titleLB setFont:[UIFont systemFontOfSize:14]];
        NSString* type= @"";
        switch (coursetype) {
            case courtseTypeHot:
                type = @"热门课程";
                break;
                
            case courseTypeNew:{

                type = @"最新课程";
                break;
                
            }
            case courseTypeFree:{
                type = @"免费课程";
            
                break;
            }
            default:
                break;
        }
        
        [_titleLB setText:type];
        [self.contentView addSubview:_titleLB];
        
        
        //计算_title绝对高度
        CGRect rect = [_titleLB.text boundingRectWithSize:CGSizeMake(screenwith, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: _titleLB.font} context:nil];
        _titleheight = rect.size.height;
        
        //滚动
        _courseScro = [UIScrollView new];
        [_courseScro setScrollEnabled:YES];
        [_courseScro setBounces:NO];
        _courseScro.delegate = self;
        [_courseScro setFrame:CGRectMake(0, 10+_titleheight, screenwith, _cellheight - 10 -_titleheight)];
        
        
         _courseScro.contentSize = CGSizeMake(screenwith/5*2*count, _cellheight - 10 -_titleheight);
        [_courseScro setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:_courseScro];

       // _objects = [NSMutableArray new];
//        [courseArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//           
//           // Course * course = (Course*)obj;
//            courseView* vi = [[courseView alloc]initWithFrameAndCourseInfo:CGRectMake(screenwith/5*2*idx, 0, screenwith/5*2,  self.contentView.frame.size.height/7*5) course:nil];
//            
//            [_courseScro addSubview:vi];
//            
//        }];


        
        
        
        [self initsubviews];
        
        
        
        [self setlayout];
        
        
        
        
        
    }
    return self;
}

-(void)initsubviews{
    
    
    
}


-(void)setlayout{

   [_objects removeAllObjects];

    
    [_titleLB zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
        layout.leftSpace(5).topSpace(5);
        
    }];
    

    for(int i =0;i<[_coursearr count];++i){
        courseView* vi = [[courseView alloc]initWithCourseInfoAndHeight:_coursearr[i] height:_cellheight - 10 -_titleheight-2];
        
        [_courseScro addSubview:vi];
        [vi zxp_addConstraints:^(ZXPAutoLayoutMaker *layout) {
            layout.leftSpace(screenwith/5*2*i+2*i).topSpace(0).widthValue(screenwith/5*2).heightValue(_cellheight - 10 -_titleheight-2);
        }];
        [_objects addObject:vi];
        
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
