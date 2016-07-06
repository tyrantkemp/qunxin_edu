//
//  courseMJ.h
//  qunxin_edu
//
//  Created by 肖准 on 6/29/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface courseMJ : NSObject
@property(nonatomic,assign) NSInteger courseId;
@property(nonatomic,strong) NSString* desc;

@property(nonatomic,assign)  NSInteger Id;
@property(nonatomic,assign)  NSInteger isFree;
@property(nonatomic,assign)  NSInteger isRecommand;
@property(nonatomic,assign)  NSInteger learnerNum;
@property(nonatomic,assign)  NSInteger level;
@property(nonatomic,assign)  NSInteger parentId;
@property(nonatomic,strong)  NSString* picUrl;
@property(nonatomic,assign)  NSInteger sort;
@property(nonatomic,strong)  NSString* title;

//@property NSString* updateTime;
@property(nonatomic,strong) NSString* videoUrl;
//
@end
