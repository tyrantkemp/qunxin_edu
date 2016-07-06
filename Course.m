//
//  Course.m
//  qunxin_edu
//
//  Created by 肖准 on 6/21/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "Course.h"

@implementation Course

// Specify default values for properties

//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}


//@property NSInteger courseId;
//@property NSString* desc;
//
//@property NSInteger Id;
//@property NSInteger isFree;
//@property NSInteger isRecommand;
//@property NSInteger learnerNum;
//@property NSInteger level;
//@property NSInteger parentId;
//@property NSString* picUrl;
//@property NSInteger sort;
//@property NSString* title;
//@property NSString* updateTime;
//@property NSString* videoUrl;
+ (NSDictionary *)JSONInboundMappingDictionary {
    
    return @{
             @"courseId":@"courseId",
             @"desc":@"desc",
             @"id":@"Id",
             @"isFree":@"isFree",
             @"isRecommand":@"isRecommand",
             @"learnerNum":@"learnerNum",
             @"level":@"level",
             @"parentId":@"parentId",
             @"picUrl":@"picUrl",
             @"sort":@"sort",
             @"title":@"title",
//             @"updateTime":@"updateTime",
             @"videoUrl":@"videoUrl"
             
             };
}
+(NSString*)primaryKey{
    return @"courseId";
}
@end
