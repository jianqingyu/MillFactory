//
//  NakedDriSeaHeadView.m
//  MillenniumStarERP
//
//  Created by yjq on 17/7/10.
//  Copyright © 2017年 com.millenniumStar. All rights reserved.
//

#import "NakedDriSeaHeadView.h"
#import "CustomShapeBtn.h"
@implementation NakedDriSeaHeadView

- (void)setTopArr:(NSArray *)topArr{
    if (topArr) {
        _topArr = topArr;
        [UIView animateWithDuration:0.1 animations:^{
            [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        }];
        NSInteger total = _topArr.count;
        CGFloat rowWid = 60;
        CGFloat rowhei = 30;
        for (int i=0; i<total; i++) {
            UIButton *btn = [self creatBtn];
            btn.frame = CGRectMake(rowWid*i,0, rowWid, rowhei);
            if (i==1) {
                NSString *imgStr;
                if ([_string isEqualToString:@"weight_desc"]) {
                    imgStr = @"icon_sort_d";
                }else if ([_string isEqualToString:@"weight_asc"]){
                    imgStr = @"icon_sort_u";
                }else{
                    imgStr = @"icon_sort";
                }
                UIButton *img = [UIButton buttonWithType:UIButtonTypeCustom];
                img.frame = CGRectMake(40, 0, 20, 30);
                [img setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
                [img addTarget:self action:@selector(sortClick:) forControlEvents:UIControlEventTouchUpInside];
                [btn addSubview:img];
                [btn addTarget:self action:@selector(sortClick:) forControlEvents:UIControlEventTouchUpInside];
            }
            if (i==total-1) {
                btn.width = 100;
            }
            [btn setTitle:_topArr[i] forState:UIControlStateNormal];
        }
    }
}

- (UIButton *)creatBtn{
    CustomShapeBtn *btn = [CustomShapeBtn buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor whiteColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [btn.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self addSubview:btn];
    return btn;
}

- (void)sortClick:(id)sender{
    NSString *imgStr;
    if ([_string isEqualToString:@"weight_desc"]) {
        imgStr = @"weight_asc";
    }else if ([_string isEqualToString:@"weight_asc"]){
        imgStr = @"";
    }else{
        imgStr = @"weight_desc";
    }
    if (self.back) {
        self.back(imgStr);
    }
}

@end
