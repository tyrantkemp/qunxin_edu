//
//  GWAutoSlideScrollView.h
//  GoldWallet
//
//  Created by qingsong on 16/1/7.
//  Copyright © 2016年 qingsong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GWAutoSlideScrollViewDelegate;

@interface GWAutoSlideScrollView : UIView <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, weak) id<GWAutoSlideScrollViewDelegate> delegate;

- (void)reloadData;

@end

@protocol GWAutoSlideScrollViewDelegate <NSObject>

- (void)autoSlideScrollView:(GWAutoSlideScrollView *)autoSlideScrollView didSelectAtIndex:(NSInteger)index;

@end
