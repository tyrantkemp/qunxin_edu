//
//  dinnerTableViewCell.h
//  qunxin_edu
//
//  Created by 肖准 on 6/29/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dinnerTableViewCell : UITableViewCell

@property(nonatomic,assign)BOOL isChecked;

@property(nonatomic,assign)void (^checkpress)(UIButton* btn);

-(instancetype)initWithStyleAndTitleAndSubTitle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier title:(NSMutableAttributedString*)attribuestring subtitle:(NSMutableAttributedString*)subtitle height:(CGFloat)height;
@end
