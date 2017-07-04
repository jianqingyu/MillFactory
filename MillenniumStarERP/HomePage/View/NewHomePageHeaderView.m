//
//  NewHomePageHeaderView.m
//  MillenniumStarERP
//
//  Created by yjq on 17/6/20.
//  Copyright © 2017年 com.millenniumStar. All rights reserved.
//

#import "NewHomePageHeaderView.h"
#import "ETFoursquareImages.h"
#import "NewHomeShopInfo.h"
#import "HYBLoopScrollView.h"
@interface NewHomePageHeaderView()
@property (nonatomic,  weak)ETFoursquareImages *foursquareImages;
@property (nonatomic,strong)NSMutableArray *arr;
@end
@implementation NewHomePageHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //添加头(尾)视图中的控件
    }
    return self;
}

- (void)setLoopScrollView:(NSArray *)arr{
    [UIView animateWithDuration:0.1 animations:^{
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }];
    CGFloat height = (int)(MAX(SDevHeight, SDevWidth))/3;
    HYBLoopScrollView *loop = [HYBLoopScrollView loopScrollViewWithFrame:
                               CGRectMake(0, 0, SDevWidth, height) imageUrls:arr];
    loop.timeInterval = 3.0;
    loop.didSelectItemBlock = ^(NSInteger atIndex,HYBLoadImageView  *sender){
        
    };
    loop.alignment = kPageControlAlignRight;
    [self addSubview:loop];
}

- (void)setScrollView{
    [UIView animateWithDuration:0.1 animations:^{
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }];
    ETFoursquareImages *Images = [[ETFoursquareImages alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [Images setImagesHeight:self.height];
    [self addSubview:Images];
    self.foursquareImages = Images;
    [self.foursquareImages setImages:_arr];
}

- (void)setInfoArr:(NSArray *)infoArr{
    if (infoArr) {
        _infoArr = infoArr;
        NSMutableArray *mutA = [NSMutableArray new];
        for (NewHomeShopInfo *info in _infoArr) {
            [mutA addObject:info.pic];
        }
        [self setLoopScrollView:mutA];
    }
}

#pragma mark - imageTapDelegate
- (void)imageTapGestureWithIndex:(int)index{
    
}

@end
