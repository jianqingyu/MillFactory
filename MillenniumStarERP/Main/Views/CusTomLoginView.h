//
//  CusTomLoginView.h
//  MillenniumStarERP
//
//  Created by yjq on 16/11/3.
//  Copyright © 2016年 com.millenniumStar. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^loginClick)(int staue);
@interface CusTomLoginView : UIView
@property (weak, nonatomic) UITextField *nameFie;
@property (weak, nonatomic) UITextField *passWordFie;
@property (nonatomic,assign)BOOL noLogin;
@property (nonatomic,copy)loginClick btnBack;
+ (CusTomLoginView *)createLoginView;
@end
