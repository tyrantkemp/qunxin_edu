//
//  User.m
//  qunxin_edu
//
//  Created by 肖准 on 6/16/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "User.h"

@implementation User

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
+ (NSDictionary *)JSONInboundMappingDictionary {

    return @{
             @"userId":@"userId",
             @"userName":@"userName"
             
             };
}

+(NSString*)primaryKey{
    return @"userId";
}

@end
