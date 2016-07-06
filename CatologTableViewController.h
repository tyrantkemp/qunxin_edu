//
//  CatologTableViewController.h
//  qunxin_edu
//
//  Created by 肖准 on 6/23/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Course.h"
@interface CatologTableViewController : UITableViewController

@property(nonatomic,strong)    NSArray* courseArr;

-(instancetype)initWithCourseArr:(NSArray*)courseArr;
@end
