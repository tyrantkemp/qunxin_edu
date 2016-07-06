//
//  CorInfo.h
//  qunxin_edu
//
//  Created by 肖准 on 6/12/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import <Realm/Realm.h>

@interface Job : RLMObject
@property NSInteger jobId;
@property NSInteger bottomSalery;
@property NSInteger topSalery;
@property NSString* localCity;
@property NSInteger bottomYear;
@property NSInteger topYear;
@property NSString* degree;

@property NSString* corIconUrl;
@property NSString* jobName;
@property NSString* corName;

@property NSString* updateTime;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<CorInfo>
RLM_ARRAY_TYPE(Job)
