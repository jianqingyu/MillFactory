//
//  NakedDriSeaHeadView.h
//  MillenniumStarERP
//
//  Created by yjq on 17/7/10.
//  Copyright © 2017年 com.millenniumStar. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^seaHedBack)(NSString *sort);
@interface NakedDriSeaHeadView : UIView
@property (nonatomic,strong)NSArray *topArr;
@property (nonatomic,  copy)NSString *string;
@property (nonatomic,copy)seaHedBack back;
@end
