//
//  CorInfo.m
//  qunxin_edu
//
//  Created by 肖准 on 6/12/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "Job.h"

@implementation Job

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

+ (NSDictionary *)JSONInboundMappingDictionary {//@property NSString* jobIndex;
//@property NSUInteger bottomSalery;
//@property NSUInteger topSalery;
//@property NSString* localCity;
//@property NSUInteger bottomYear;
//@property NSUInteger topYear;
//@property NSString* degree;
//
//@property UIImageView* corIcon;
//@property NSString* jobName;
//@property NSString* corName;
//
//@property NSDate* updateTime;

    return @{
             @"bottomSalery":@"bottomSalery",
             @"topSalery": @"topSalery",
             @"bottomYear":@"bottomYear",
             @"localCity":@"localCity",
             @"jobId":@"jobId",
             @"topYear":@"topYear",
             @"degree": @"degree",
             @"corIconUrl":@"corIconUrl",
             
             @"jobName": @"jobName",
             @"corName":@"corName",
             @"updateTime":@"updateTime"
             
             
             };
}
+(NSString*)primaryKey{
    return @"jobId";
}
@end
