//
//  BMImageView.h
//  badminton
//
//  Created by qingsong on 15/6/3.
//  Copyright (c) 2015年 glzc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UIImage *(^TGImageProcessor)(UIImage *);
typedef UIImage *(^TGImageUniversalProcessor)(NSString *, UIImage *);


@interface BMImageView : UIImageView

+ (TGImageProcessor)imageProcessorForName:(NSString *)name;

+ (void)registerImageProcessor:(TGImageProcessor)imageProcessor withName:(NSString *)name;

- (void)sd_loadImageWithURL:(NSString *)url
           placeholderImage:(UIImage *)placeholderImage
                     filter:(NSString *)filter
                       done:(void (^)(UIImage *image))done;



@end
