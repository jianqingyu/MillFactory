//
//  DetailWebViewVC.m
//  MillenniumStarERP
//
//  Created by yjq on 17/8/5.
//  Copyright © 2017年 com.millenniumStar. All rights reserved.
//

#import "DetailWebViewVC.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface DetailWebViewVC ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation DetailWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文案详情";
    _webView.scrollView.bounces = NO;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    //    [_webView sizeToFit];
    
    NSString *url = @"http://www.baidu.com";
    NSURLRequest *urlRe = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:urlRe];
    JSContext *context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"gotoProductClass"] = ^() {
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args){
            NSString *str = [NSString stringWithFormat:@"%@",jsVal];
            //通过categotyId打开列表页
            NSLog(@"%@",str);
        }
    };
}

@end
