//
//  InfoViewController.m
//  qunxin_edu
//
//  Created by 肖准 on 6/24/16.
//  Copyright © 2016 肖准. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()<UIScrollViewDelegate>{
    UIScrollView* _scroview;
    
}

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];

    [self initsubviews];
    [self setlayouts];
    // Do any additional setup after loading the view.
}

-(void)initsubviews{
    
    _scroview = [UIScrollView new];
    [_scroview setScrollEnabled:YES];
    [_scroview setBounces:YES];
    [_scroview setShowsHorizontalScrollIndicator:NO];
    [_scroview setShowsVerticalScrollIndicator:NO];
    
    [_scroview setFrame:CGRectMake(0, 0, screenwith, screenheight)];
    [_scroview setContentSize:CGSizeMake(screenwith, screenheight)];
    [self.view addSubview:_scroview];

    
    
}


-(void)setlayouts{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
