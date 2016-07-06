//
//  courseView.h
//  qunxin_edu
//
//  Created by 肖准 on 6/21/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Course.h"
#import "courseMJ.h"
@interface courseView : UIView

@property(nonatomic,copy)void (^courseTap)(NSString* url);


-(instancetype)initWithCourseInfoAndHeight:(courseMJ*) course height:(CGFloat)height;
@end
