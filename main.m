//
//  main.m
//  qunxin_edu
//
//  Created by 肖准 on 6/5/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        //听云 监控
        [NBSAppAgent startWithAppID:@"acbdfc7ebdc64ff3ac4eb15111e35a8a"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
