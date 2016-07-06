//
//  courseToolBar.h
//  qunxin_edu
//
//  Created by 肖准 on 6/26/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface courseToolBar : UIToolbar

@property(nonatomic,strong)UIButton* starBtn;
@property(nonatomic,strong)UIButton * shareBtn;
@property(nonatomic,strong)UIButton* preBtn;
@property(nonatomic,strong)UIButton* nextBtn;


@property(nonatomic,assign)BOOL isStared;


@property(nonatomic,copy)void (^sharePressed)(void);
@property(nonatomic,copy)void (^prePressed)(void);
@property(nonatomic,copy)void (^nextPressed)(void);
@property(nonatomic,copy)void (^starPressed)(void);

@end
