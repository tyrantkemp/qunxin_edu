//
//  Course.h
//  qunxin_edu
//
//  Created by 肖准 on 6/21/16.
//  Copyright © 2016 肖准. All rights reserved.
//

//courseId = 1;
//createTime = 1466257335000;
//desc = "\U5feb\U901f\U914d\U7f6e xUtils3";
//id = 7;
//isFree = 1;
//isRecommand = 1;
//learnerNum = 33;
//level = 2;
//parentId = 1;
//picUrl = "/upload/android_1.jpg";
//sort = 1;
//title = "\U5feb\U901f\U914d\U7f6e xUtils3";
//updateTime = 1466913052000;
//videoUrl = videoUrl1;



#import <Realm/Realm.h>

@interface Course : RLMObject
@property NSInteger courseId;
@property NSString* desc;

@property NSInteger Id;
@property NSInteger isFree;
@property NSInteger isRecommand;
@property NSInteger learnerNum;
@property NSInteger level;
@property NSInteger parentId;
@property NSString* picUrl;
@property NSInteger sort;
@property NSString* title;

//@property NSString* updateTime;
@property NSString* videoUrl;
//
//@property NSString* iconUrl;
//@property NSString* speakerName;
//@property NSString* orgName;
//@property NSString* courseDescribe;
//@property NSString* preliminary;
//@property NSString* outline;
//@property NSString* refrence;
//@property NSInteger collectCount;
//@property NSString* operatorName;
//@property NSString* createTime;
//@property NSString* duration;
//@property NSString* load;
//@property NSString* category;
//@property NSString* grade;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Course>
RLM_ARRAY_TYPE(Course)
