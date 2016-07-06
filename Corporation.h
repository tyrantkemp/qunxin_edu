//
//  Corporation.h
//  qunxin_edu
//
//  Created by 肖准 on 6/5/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import <Realm/Realm.h>
#import "Job.h"
@interface Corporation : RLMObject
@property NSInteger corId;
@property NSString* corName;
@property NSString* iconUrl;
@property NSInteger jobNumber;
@property NSString* employeeRange;
@property NSString* corType;
@property NSString* corIntro;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<Corporation>
RLM_ARRAY_TYPE(Corporation)
