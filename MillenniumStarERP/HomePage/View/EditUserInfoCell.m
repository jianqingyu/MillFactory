//
//  EditUserInfoCell.m
//  MillenniumStarERP
//
//  Created by yjq on 17/6/28.
//  Copyright © 2017年 com.millenniumStar. All rights reserved.
//

#import "EditUserInfoCell.h"
@interface EditUserInfoCell()
@property (weak, nonatomic) IBOutlet UISwitch *showBtn;
@property (weak, nonatomic) IBOutlet UITextField *shopFie;
@property (weak, nonatomic) IBOutlet UITextField *driFie;
@end
@implementation EditUserInfoCell

+ (id)cellWithTableView:(UITableView *)tableView{
    static NSString *Id = @"customCell";
    EditUserInfoCell *customCell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (customCell==nil) {
        customCell = [[EditUserInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
        customCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return customCell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"EditUserInfoCell" owner:nil
                                          options:nil][0];
    }
    return self;
}

- (IBAction)showPriceClick:(id)sender {
    
}

- (IBAction)shopAccClick:(id)sender {
    int str = [self.shopFie.text intValue];
    if (str==0) {
        return;
    }
    str--;
    self.shopFie.text = [NSString stringWithFormat:@"%d",str];
}

- (IBAction)shopAddClick:(id)sender {
    int str = [self.shopFie.text intValue];
    str++;
    self.shopFie.text = [NSString stringWithFormat:@"%d",str];
}

- (IBAction)driAccClick:(id)sender {
    int str = [self.driFie.text intValue];
    if (str==0) {
        return;
    }
    str--;
    self.driFie.text = [NSString stringWithFormat:@"%d",str];
}

- (IBAction)driAddClick:(id)sender {
    int str = [self.driFie.text intValue];
    str++;
    self.driFie.text = [NSString stringWithFormat:@"%d",str];
}

@end
