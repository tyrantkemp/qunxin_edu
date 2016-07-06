//
//  constants.h
//  qunxin_edu
//
//  Created by 肖准 on 6/7/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#ifndef constants_h
#define constants_h

#define viewwith self.view.frame.size.width
#define viewheight self.view.frame.size.height
#define screenwith [[UIScreen  mainScreen ] bounds].size.width
#define screenheight [[UIScreen  mainScreen ] bounds].size.height


#define MAIN_PREFIX @"http://tyrantkemp.imwork.net:21158/imgServ/action/"
#define LOGIN @"login_validate"
#define MAIN_CORPORATION @"corporation"

#define MAIN_PAGE_COURSES @"MAIN_PAGE_COURSES"
#define COR_INFO @"corporationInfo"
#define MAIN_SUFFIX @"PageSize=20"




//#define Local
#ifdef Local
#define MAIN @"http:tyrantkemp.imwork.net:21158/camp-api/"
#define IP @"http:tyrantkemp.imwork.net:21158"
#else
#define MAIN @"http://139.196.21.175:18080/api/"
#define IP @"http://139.196.21.175:18080"
#endif

#define COURSE @"course/"
#define GETCOURSE_BY_SEARCH @"getCourseByCondition"
#define GETCOURSEINFO @"getCourseChapterByTypeByGet?type=0"
#define GETSECTIONINFO @"getCourseChapterClassByGet"
#define GETCOURSETYPEINFO @"getCourseMenuByGet"


//消息
#define QUIT_REGISTER @"quit_register"



//tag
#define DINNER_MONTH_VIP 1001
#define DINNER_YEAE_VIP 1001

#define PAY_WAY_ZHIFU 2001
#define PAY_WAY_WECHAT 2002

#define ISDEBUG 0;

#endif /* constants_h */
