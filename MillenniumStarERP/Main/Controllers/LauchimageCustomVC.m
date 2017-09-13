//
//  LauchimageCus/Users/yjq/Desktop/MillFactory/MillenniumStarERPtomVC.m
//  MillenniumStarERP
//
//  Created by yjq on 17/8/1.
//  Copyright © 2017年 com.millenniumStar. All rights reserved.
//

#import "LauchimageCustomVC.h"
#import "LoginViewController.h"
@interface LauchimageCustomVC ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *home1;
@property (weak, nonatomic) IBOutlet UIImageView *home2;
@property (weak,  nonatomic) IBOutlet UIButton *btn;
@property (nonatomic,  weak) NSTimer *timer;
@property (nonatomic,assign) int i;
@end

@implementation LauchimageCustomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.i = 5;
    _timer =  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeClick:) userInfo:nil repeats:YES];
    [UIView animateWithDuration:5 animations:^{
        self.home1.alpha = 0;
        self.home2.alpha = 1;
    }];
//    _webView.scrollView.bounces = NO;
//    _webView.scrollView.showsHorizontalScrollIndicator = NO;
//    _webView.scrollView.showsVerticalScrollIndicator = NO;
//    _webView.delegate = self;
//    NSString *str = @"http://c.eqxiu.com/s/lPiERT7d?eqrcode=1&from=timeline&isappinstalled=0";
//    NSURLRequest *urlRe = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
//    [self.webView loadRequest:urlRe];
}

- (void)timeClick:(id)user{
    if (self.i==1) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = [[LoginViewController alloc]init];
         [_timer invalidate];
        _timer = nil;
    }
    self.i--;
    [self.btn setTitle:[NSString stringWithFormat:@"跳过 %d",self.i] forState:UIControlStateNormal];
}

- (IBAction)openClick:(id)sender {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[LoginViewController alloc]init];
}

@end
