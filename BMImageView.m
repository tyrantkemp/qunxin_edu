//
//  BMImageView.m
//  badminton
//
//  Created by qingsong on 15/6/3.
//  Copyright (c) 2015年 glzc. All rights reserved.
//

#import "BMImageView.h"
#import "UIImageView+WebCache.h"
#import "TGImageUtils.h"

@implementation BMImageView

+ (NSMutableDictionary *)imageProcessors
{
    static NSMutableDictionary *dictionary = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      dictionary = [[NSMutableDictionary alloc] init];
                  });
    return dictionary;
}

+ (NSMutableDictionary *)universalImageProcessors
{
    static NSMutableDictionary *dictionary = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      dictionary = [[NSMutableDictionary alloc] init];
                  });
    return dictionary;
}

+ (TGImageProcessor)imageProcessorForName:(NSString *)name
{
    TGImageProcessor processor = [[BMImageView imageProcessors] objectForKey:name];
    if (processor != nil)
        return processor;
    
    NSRange range = [name rangeOfString:@":"];
    if (range.location != NSNotFound)
    {
        NSString *baseName = [name substringToIndex:range.location];
        TGImageUniversalProcessor universalProcessor = [[BMImageView universalImageProcessors] objectForKey:baseName];
        if (universalProcessor != nil)
        {
            return ^UIImage *(UIImage *source)
            {
                return universalProcessor(name, source);
            };
        }
    }
    
    return nil;
}

+ (void)registerImageProcessor:(TGImageProcessor)imageProcessor withName:(NSString *)name {
    [[BMImageView imageProcessors] setObject:[imageProcessor copy] forKey:name];
}

- (void)sd_loadImageWithURL:(NSString *)url
           placeholderImage:(UIImage *)placeholderImage
                     filter:(NSString *)filter
                       done:(void (^)(UIImage *image))done {

//    [self setImage:placeholderImage];
//    
//    NSURL *URL = [NSURL URLWithString:url];
//    NSString *filterKey = [NSString stringWithFormat:@"filterImageView%@ : %@", filter ,url];
//    
//    __weak __typeof(self) weakSelf = self;
//    
//    dispatch_block_t block = ^{
//        NSLog(@"没有缓存");
//        
//        [self sd_setImageWithURL:URL placeholderImage:placeholderImage completed:^(UIImage *rawImage, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
//            __strong BMImageView *strongSelf = weakSelf;
//            
//            if (rawImage != nil) {
//                UIImage *newImage;
//                
//                TGImageProcessor procesor = [BMImageView imageProcessorForName:filter];
//                if (procesor != nil)
//                    newImage = procesor(rawImage);
//                
////                if (done) {
////                    done(newImage);
////                }
//                
//                [strongSelf setImage:newImage];
//                
//                [[SDImageCache sharedImageCache] storeImage:newImage forKey:filterKey];
//            }
//            
//            if (error) {
//                NSLog(@"加载图片出错 : %@", error);
//            }
//        }];
//    };
//    
//    __strong BMImageView *strongSelf = weakSelf;
//    [[SDImageCache sharedImageCache] queryDiskCacheForKey:filterKey done:^(UIImage *image, SDImageCacheType cacheType) {
//        NSLog(@"search result ...");
//        if (!image) {
//            NSLog(@"not cached ...");
//            block();
//        } else {
//            NSLog(@"cached");
////            if (done) {
////                done(image);
////            }
//            [strongSelf setImage:image];
//        }
//    }];
    
    [self setImage:placeholderImage];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSString *filterKey = [NSString stringWithFormat:@"filterImageView%@ : %@", filter ,url];
    
    __weak __typeof(self) weakSelf = self;
    
    dispatch_block_t block = ^{
//        NSLog(@"没有缓存");
        
        [self sd_setImageWithURL:URL placeholderImage:placeholderImage completed:^(UIImage *rawImage, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
            __strong BMImageView *strongSelf = weakSelf;
            
            if (rawImage != nil) {
                UIImage *newImage;
                
                TGImageProcessor procesor = [BMImageView imageProcessorForName:filter];
                if (procesor != nil)
                    newImage = procesor(rawImage);
                
                if (done) {
                    done(newImage);
                }
                
                [strongSelf setImage:newImage];
                
                [[SDImageCache sharedImageCache] storeImage:newImage forKey:filterKey];
            }
            
            if (error) {
//                NSLog(@"加载图片出错 : %@", error);
            }
        }];
    };
    
    __strong BMImageView *strongSelf = weakSelf;
    [[SDImageCache sharedImageCache] queryDiskCacheForKey:filterKey done:^(UIImage *image, SDImageCacheType cacheType) {
//        NSLog(@"search result ...");
        if (!image) {
//            NSLog(@"not cached ...");
            block();
        } else {
//            NSLog(@"cached");
            if (done) {
                done(image);
            }
            [strongSelf setImage:image];
        }
    }];

}


@end
