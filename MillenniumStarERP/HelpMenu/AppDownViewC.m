//
//  AppDownViewC.m
//  MillenniumStarERP
//
//  Created by yjq on 17/3/8.
//  Copyright © 2017年 com.millenniumStar. All rights reserved.
//

#import "AppDownViewC.h"

@interface AppDownViewC ()
@property (weak, nonatomic) IBOutlet UIImageView *codeImg;
@end

@implementation AppDownViewC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"版本详情";
    self.dict = @{@"image":@"iOSCode",@"url":@"https://www.pgyer.com/nufA"};
    self.codeImg.image = [UIImage imageNamed:self.dict[@"image"]];
}

- (IBAction)btnClick:(id)sender {
    UIApplication *application = [UIApplication sharedApplication];
    [application openURL:[NSURL URLWithString:self.dict[@"url"]]];
    application = nil;
}

@end
