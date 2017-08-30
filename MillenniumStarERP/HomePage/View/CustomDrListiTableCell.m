//
//  CustomDrListiTableCell.m
//  MillenniumStarERP
//
//  Created by yjq on 17/8/30.
//  Copyright © 2017年 com.millenniumStar. All rights reserved.
//

#import "CustomDrListiTableCell.h"
#import "SearchDateInfo.h"
@interface CustomDrListiTableCell()
@property (weak, nonatomic) IBOutlet UIScrollView *dirScroll;
@property (nonatomic,strong)NSMutableArray *mutA;
@end
@implementation CustomDrListiTableCell

+ (id)cellWithTableView:(UITableView *)tableView{
    static NSString *Id = @"driListCell";
    CustomDrListiTableCell *customCell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (customCell==nil) {
        customCell = [[CustomDrListiTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
        customCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return customCell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"CustomDrListiTableCell" owner:nil options:nil][0];
        self.mutA = @[].mutableCopy;
        SearchDateInfo *info1 = [SearchDateInfo new];
        info1.title = @"90分";
        info1.isDefault = YES;
        SearchDateInfo *info2 = [SearchDateInfo new];
        info2.title = @"80分";
        info2.isDefault = NO;
        SearchDateInfo *info3 = [SearchDateInfo new];
        info3.title = @"70分";
        info3.isDefault = NO;
        SearchDateInfo *info4 = [SearchDateInfo new];
        info4.title = @"60分";
        info4.isDefault = NO;
        SearchDateInfo *info5 = [SearchDateInfo new];
        info5.title = @"50分";
        info5.isDefault = NO;
        [self creatBaseView:@[info1,info2,info3,info4,info5]];
    }
    return self;
}

- (void)setListArr:(NSArray *)listArr{
    if (listArr) {
        _listArr = listArr;
        [self creatBaseView:_listArr];
    }
}

- (void)creatBaseView:(NSArray *)arr{
    CGFloat space = 10;
    CGFloat height = 30;
    CGFloat curX = 0;
    CGFloat width = 0;
    CGFloat vW = 0;
    for (int i=0; i<arr.count; i++) {
        SearchDateInfo *info = arr[i];
        UIButton *btn = [self creatBtn];
        UIButton *btnL;
        if (i>0) {
            btnL = self.mutA[i-1];
        }
        curX = CGRectGetMaxX(btnL.frame)+space;
        btn.tag = i;
        btn.selected = info.isDefault;
        [btn setTitle:info.title forState:UIControlStateNormal];
        CGRect rect = CGRectMake(0, 0, SDevWidth-30, 999);
        rect = [btn.titleLabel textRectForBounds:rect limitedToNumberOfLines:0];
        width = rect.size.width+10;
        btn.frame = CGRectMake(curX, 15, width, height);
        vW = CGRectGetMaxX(btn.frame)+15;
    }
    self.dirScroll.contentSize = CGSizeMake(vW, 0);
}

- (UIButton *)creatBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor whiteColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setBackgroundImage:[CommonUtils createImageWithColor:DefaultColor]
                   forState:UIControlStateNormal];
    [btn setBackgroundImage:[CommonUtils createImageWithColor:MAIN_COLOR]
                   forState:UIControlStateSelected];
    [btn setLayerWithW:5 andColor:BordColor andBackW:0.0001];
    [btn addTarget:self action:@selector(btnClick:)forControlEvents:UIControlEventTouchUpInside];
    [self.dirScroll addSubview:btn];
    [self.mutA addObject:btn];
    return btn;
}

- (void)btnClick:(UIButton *)sender{
    for (int i=0; i<self.mutA.count; i++) {
        UIButton *sBtn = self.mutA[i];
        if (i!=(int)sender.tag) {
            sBtn.selected = NO;
        }
    }
    sender.selected = !sender.selected;
}

@end
