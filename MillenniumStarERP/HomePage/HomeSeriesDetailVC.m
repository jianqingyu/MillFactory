//
//  HomeSeriesDetailVC.m
//  MillenniumStarERP
//
//  Created by yjq on 17/6/23.
//  Copyright © 2017年 com.millenniumStar. All rights reserved.
//

#import "HomeSeriesDetailVC.h"
#import "ProductInfo.h"
#import "NewHomePageCollCell.h"
#import "HomeSeriesHeadView.h"
#import "CustomProDetailVC.h"
#import "ProductCollectionCell.h"
#import "NewCustomProDetailVC.h"
@interface HomeSeriesDetailVC ()<UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,   copy) NSString *photos;
@property (nonatomic,assign)BOOL isShowPrice;
@property (nonatomic,strong)NSString *picUrl;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (strong,nonatomic)UICollectionView *homeCollection;
@end

@implementation HomeSeriesDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray new];
    [self loadNewHomeData];
    [self setCollectionView];
    [self creatNaviBtn];
    self.isShowPrice = [[AccountTool account].isShow intValue];
    self.picUrl = @"http://appapi2.fanerweb.com/images/ad/20170727/round1.jpg";
    self.view.backgroundColor = DefaultColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)orientChange:(NSNotification *)notification{
    [self.homeCollection reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (void)creatNaviBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 20, 54, 54);
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
}

- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadNewHomeData{
    [SVProgressHUD show];
    NSString *url = [NSString stringWithFormat:@"%@modelListPage",baseUrl];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"tokenKey"] = [AccountTool account].tokenKey;
    params[@"linkKey"] = _seaKey;
    [BaseApi getGeneralData:^(BaseResponse *response, NSError *error) {
        if ([response.error intValue]==0) {
            if ([YQObjectBool boolForObject:response.data]) {
                NSArray *seaArr = [ProductInfo objectArrayWithKeyValuesArray:response.data[@"model"][@"modelList"]];
                [_dataArray addObjectsFromArray:seaArr];
                [self.homeCollection reloadData];
            }
        }
    } requestURL:url params:params];
}

- (void)setCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 10.0f;//左右间隔
    flowLayout.minimumLineSpacing = 10.0f;//上下间隔
    flowLayout.sectionInset = UIEdgeInsetsMake(10,10,10,10);//边距距
    self.homeCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.homeCollection.backgroundColor = DefaultColor;
    self.homeCollection.delegate = self;
    self.homeCollection.dataSource = self;
    [self.view addSubview:_homeCollection];
    [_homeCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    //设置当数据小于一屏幕时也能滚动
    self.homeCollection.alwaysBounceVertical = YES;
    UINib *nib = [UINib nibWithNibName:@"ProductCollectionCell" bundle:nil];
    [self.homeCollection registerNib:nib
           forCellWithReuseIdentifier:@"ProductCollectionCell"];
    
    [self.homeCollection registerClass:[HomeSeriesHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];             //注册头视图
}

#pragma mark--CollectionView-------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductCollectionCell *collcell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCollectionCell" forIndexPath:indexPath];
    collcell.isShow = !self.isShowPrice;
    ProductInfo *proInfo;
    if (indexPath.row<self.dataArray.count) {
        proInfo = self.dataArray[indexPath.row];
    }
    collcell.proInfo = proInfo;
    return collcell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat rowH = self.isShowPrice?64:33;
    int num = SDevWidth>SDevHeight?4:2;
    CGFloat width = (SDevWidth-(num+1)*10)/num;
    return CGSizeMake(width, width+rowH);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {       //头视图
        HomeSeriesHeadView *headV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
        [headV.image sd_setImageWithURL:[NSURL URLWithString:self.picUrl] placeholderImage:DefaultImage];
        reusableView = headV;
    }
    return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return CGSizeMake(SDevWidth,SDevWidth/1.56);
    }
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductInfo *info = self.dataArray[indexPath.row];
    if ([[AccountTool account].isSel intValue]==0) {
        NewCustomProDetailVC *newVc = [NewCustomProDetailVC new];
        newVc.proId = info.id;
        [self.navigationController pushViewController:newVc animated:YES];
    }else{
        CustomProDetailVC *customDeVC = [CustomProDetailVC new];
        customDeVC.proId = info.id;
        [self.navigationController pushViewController:customDeVC animated:YES];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
