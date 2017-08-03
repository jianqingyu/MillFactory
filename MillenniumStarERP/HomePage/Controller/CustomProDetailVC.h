//
//  CustomProDetailVC.h
//  MillenniumStarERP
//
//  Created by yjq on 16/9/13.
//  Copyright © 2016年 com.millenniumStar. All rights reserved.
//

#import "BaseViewController.h"
#import "NakedDriSeaListInfo.h"
typedef void (^ EditOrderBack)(id orderInfo);
@interface CustomProDetailVC : BaseViewController
@property (nonatomic,assign)int proId;
@property (nonatomic,assign)int qualityId;
@property (nonatomic,assign)int colorId;
@property (nonatomic,assign)int isEdit;
@property (nonatomic,  copy)EditOrderBack orderBack;
@property (nonatomic,strong)NakedDriSeaListInfo *seaInfo;
@end
