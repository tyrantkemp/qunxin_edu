//
//  User.h
//  qunxin_edu
//
//  Created by 肖准 on 6/16/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import <Realm/Realm.h>

@interface User : RLMObject
@property NSInteger userId;
@property NSString* userName;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<User>
RLM_ARRAY_TYPE(User)
