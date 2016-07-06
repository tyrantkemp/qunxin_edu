//
//  Corporation.m
//  qunxin_edu
//
//  Created by 肖准 on 6/5/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "Corporation.h"

@implementation Corporation

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
             @"corId":@"corId",
             @"corName": @"corName",
             @"iconUrl":@"iconUrl",
             @"jobNumber":@"jobNumber"
             };
}
+(NSString*)primaryKey{
    return @"corId";
}
@end
