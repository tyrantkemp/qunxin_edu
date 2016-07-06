//
//  GLStringUtils.h
//  GLPay
//
//  Created by ckcl1987 on 15/4/29.
//  Copyright (c) 2015年 glzc. All rights reserved.
//

#import <Foundation/Foundation.h>


#ifdef __cplusplus
extern "C" {
#endif
    
    int32_t murMurHash32(NSString *string);
    
    int32_t phoneMatchHash(NSString *phone);
    
#ifdef __cplusplus
}
#endif

@interface GLStringUtils : NSObject

+ (NSString *)stringByEscapingForURL:(NSString *)string;
+ (NSString *)stringByEncodingInBase64:(NSData *)data;
+ (NSString *)stringByUnescapingFromHTML:(NSString *)srcString;

+ (NSString *)md5:(NSString *)string;

+ (NSString *)formatPhoneUrl:(NSString *)phone;

+ (NSString *)cleanPhone:(NSString *)phone;

+ (NSDictionary *)argumentDictionaryInUrlString:(NSString *)string;

+ (bool)stringContainsEmoji:(NSString *)string;

@end

@interface NSString (GLPay)

- (int)lengthByComposedCharacterSequences;
- (int)lengthByComposedCharacterSequencesInRange:(NSRange)range;

- (NSData *)dataByDecodingHexString;

@end

@interface NSData (GLPay)

- (NSString *)stringByEncodingInHex;

@end