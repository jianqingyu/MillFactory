//
//  ProductListVC.m
//  MillenniumStarERP
//
//  Created by yjq on 16/9/8.
//  Copyright © 2016年 com.millenniumStar. All rights reserved.
//

#import "ProductListVC.h"
#import "YQItemTool.h"
#import "ProductCollectionCell.h"
#import "ProductPopView.h"
#import "ScanViewController.h"
#import "CustomProDetailVC.h"
#import "AllListPopView.h"
#import "CDRTranslucentSideBar.h"
#import "ScreeningRightView.h"
#import "ProductInfo.h"
#import "ScreeningInfo.h"
#import "StrWithIntTool.h"
#import "DetailTypeInfo.h"
#import "ClassListController.h"
#import "OrderListController.h"
#import "ConfirmOrderVC.h"
#import "OrderNumTool.h"
#import "CustomTextField.h"
@interface ProductListVC ()<UICollectionViewDataSource,UICollectionViewDelegate,
                             UITextFieldDelegate,CDRTranslucentSideBarDelegate>{
    int curPage;
    int pageCount;
    int totalCount;//商品总数量
}
@property (weak, nonatomic) UITextField *searchFie;
@property(strong,nonatomic) UICollectionView *rightCollection;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLab;
@property (copy, nonatomic) NSString *keyWord;
@property (nonatomic, assign) int index;
@property (nonatomic,   weak) UIView *baView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) AllListPopView *popClassView;
@property (nonatomic, strong) CDRTranslucentSideBar *rightSideBar;
@property (nonatomic, strong) ScreeningRightView *slideRightTab;
@property (nonatomic, assign)BOOL isShowPrice;
@end

@implementation ProductListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBaseAllViewData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)orientChange:(NSNotification *)notification{
    self.popClassView.frame = CGRectMake(0, 40, SDevWidth, SDevHeight-40);
    [self.rightCollection reloadData];
}

- (void)setBaseAllViewData{
    self.backDict = [NSMutableDictionary new];
    self.dataArray = [NSMutableArray new];
    self.orderNumLab.layer.cornerRadius = 8;
    self.orderNumLab.layer.masksToBounds = YES;
    [self.orderNumLab setAdjustsFontSizeToFitWidth:YES];
    curPage = 1;
    [self setupSearchBar];
    [self setupRightItem];
    [self setupRightSiderBar];
    [self setProTableView];
    [self setPopView];
    [self setupHeaderRefresh];
    [self creatNearNetView:^(BOOL isWifi) {
        [self.rightCollection.header beginRefreshing];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    App;
    [OrderNumTool orderWithNum:app.shopNum andView:self.orderNumLab];
}

#pragma mark -- 创建导航按钮-头视图
- (void)setProTableView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 5.0f;
    flowLayout.minimumInteritemSpacing = 5.0f;//左右间隔
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);//边距距
    self.rightCollection = [[UICollectionView alloc] initWithFrame:CGRectZero
                                               collectionViewLayout:flowLayout];
    self.rightCollection.backgroundColor = DefaultColor;
    self.rightCollection.delegate = self;
    self.rightCollection.dataSource = self;
    [self.view addSubview:_rightCollection];
    [_rightCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(40.5);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    //设置当数据小于一屏幕时也能滚动
    self.rightCollection.alwaysBounceVertical = YES;
    UINib *nib = [UINib nibWithNibName:@"ProductCollectionCell" bundle:nil];
    [self.rightCollection registerNib:nib
           forCellWithReuseIdentifier:@"ProductCollectionCell"];
    
    UIView *bView = [UIView new];
    bView.backgroundColor = CUSTOM_COLOR_ALPHA(0, 0, 0, 0.5);
    [self.view addSubview:bView];
    [bView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(2*SDevHeight);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    self.baView = bView;
}

- (void)setupSearchBar{
    CGFloat width = SDevWidth*0.70;
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,  width, 30)];
    [titleView setLayerWithW:5 andColor:BordColor andBackW:0.5];
    titleView.backgroundColor = [UIColor clearColor];
    CustomTextField *titleFie = [[CustomTextField alloc]initWithFrame:CGRectZero];
    [titleView addSubview:titleFie];
    titleFie.borderStyle = UITextBorderStyleNone;
    [titleFie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleView).offset(10);
        make.top.equalTo(titleView).offset(0);
        make.right.equalTo(titleView).offset(-40);
        make.height.mas_equalTo(@30);
    }];
    titleFie.delegate = self;

    UIButton *seaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [seaBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    [seaBtn setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    [titleView addSubview:seaBtn];
    [seaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView).offset(0);
        make.left.equalTo(titleFie.mas_right).with.offset(0);
        make.right.equalTo(titleView).offset(0);
        make.height.mas_equalTo(@30);
    }];
    _searchFie = titleFie;
    self.navigationItem.titleView = titleView;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchClick];
    return YES;
}

- (void)searchClick{
    [_searchFie resignFirstResponder];
    NSMutableArray *addArr = @[].mutableCopy;
    if (_searchFie.text.length>0) {
        NSArray *arr = [_searchFie.text componentsSeparatedByString:@" "];
        for (NSString *str in arr) {
            if (![str isEqualToString:@""]) {
                [addArr addObject:str];
            }
        }
        self.keyWord = [StrWithIntTool strWithArr:addArr];
        [self changeTextFieKeyWord:self.keyWord];
    }
    if (self.keyWord.length>0&&_searchFie.text.length==0) {
        [self changeTextFieKeyWord:@""];
    }
}

- (void)setupRightItem{
    UIView *right = [YQItemTool setItem:self Action:@selector(scan:)
                                               image:@"iocn_qr" title:@"扫一扫"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
}

- (void)scan:(id)sender{
    ScanViewController *scan = [ScanViewController new];
    scan.scanBack = ^(id message){
        [self changeTextFieKeyWord:message];
    };
    [self.navigationController pushViewController:scan animated:YES];
}

- (void)changeTextFieKeyWord:(NSString *)searchWord{
    _searchFie.text = searchWord;
    _keyWord = searchWord;
    [self.rightCollection.header beginRefreshing];
}

#pragma mark -- 创建侧滑菜单
- (void)setupRightSiderBar{
    CGFloat width = MIN(SDevWidth, SDevHeight);
    CGFloat height = MAX(SDevWidth, SDevHeight);
    self.rightSideBar = [[CDRTranslucentSideBar alloc] initWithDirection:YES];
    self.rightSideBar.delegate = self;
    self.rightSideBar.sideBarWidth = width*0.8;
    CGRect frame = CGRectMake(0, 20, width*0.8, height-20);
    ScreeningRightView *slideTab = [[ScreeningRightView alloc]initWithFrame:frame];
    slideTab.isTop = YES;
    slideTab.tableBack = ^(NSDictionary *dict,BOOL isSel){
        [self.backDict removeAllObjects];
        [self.backDict addEntriesFromDictionary:dict];
        [self.rightCollection.header beginRefreshing];
    };
    [self.rightSideBar setContentViewInSideBar:slideTab];
    slideTab.rightSideBar = self.rightSideBar;
    self.slideRightTab = slideTab;
}

#pragma mark - Gesture Handler 侧滑出菜单
- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.rightSideBar.isCurrentPanGestureTarget = YES;
    }
    [self.rightSideBar handlePanGestureToShow:recognizer inView:self.view];
}

#pragma mark - CDRTranslucentSideBarDelegate
- (void)sideBar:(CDRTranslucentSideBar *)sideBar willAppear:(BOOL)animated
{
    if (self.titleBtn.selected){
        self.titleBtn.selected = NO;
    }
    [self.popClassView removeFromSuperview];
    [self.baView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
    }];
}

- (void)sideBar:(CDRTranslucentSideBar *)sideBar willDisappear:(BOOL)animated
{
    [self.baView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(2*SDevHeight);
    }];
}

#pragma mark -- 顶部5个按钮
- (IBAction)classList:(UIButton *)sender {
    [_searchFie resignFirstResponder];
    self.titleBtn.selected = !self.titleBtn.selected;
    if (self.titleBtn.selected) {
        [self.view addSubview:self.popClassView];
    }else{
        [self.popClassView removeFromSuperview];
    }
}

- (IBAction)currentOrder:(id)sender {
    ConfirmOrderVC *orderVC = [ConfirmOrderVC new];
    [self.navigationController pushViewController:orderVC animated:YES];
}

- (IBAction)historyOrder:(id)sender {
    OrderListController *listVC = [OrderListController new];
    [self.navigationController pushViewController:listVC animated:YES];
}

- (IBAction)classifyQuery:(id)sender {
    ClassListController *classVc = [ClassListController new];
    classVc.listBack = ^(BOOL isYes){
        if (isYes) {
            [self.rightCollection.header beginRefreshing];
        }
    };
    [self.navigationController pushViewController:classVc animated:YES];
}

- (IBAction)screenyClick:(id)sender {
    [_searchFie resignFirstResponder];
    [self.rightSideBar show];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.titleBtn.selected){
        self.titleBtn.selected = NO;
    }
    [self.popClassView removeFromSuperview];
}

//弹出视图
- (void)setPopView{
    CGRect allFrame = CGRectMake(0, 40, SDevWidth, SDevHeight-40);
    AllListPopView *allPop = [[AllListPopView alloc]initWithFrame:allFrame];
    allPop.popBack = ^(id dict){
        if (self.titleBtn.selected){
            self.titleBtn.selected = NO;
        }
        [_backDict removeAllObjects];
        _titleLab.text = [dict allValues][0];
        _backDict[@"category"] = [dict allKeys][0];
        [self changeTextFieKeyWord:@""];
    };
    self.popClassView = allPop;
}

#pragma mark -- 网络请求
- (void)setupHeaderRefresh{
    // 刷新功能
    MJRefreshStateHeader*header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self headerRereshing];
    }];
    [header setTitle:@"用力往下拉我!!!" forState:MJRefreshStateIdle];
    [header setTitle:@"快放开我!!!" forState:MJRefreshStatePulling];
    [header setTitle:@"努力刷新中..." forState:MJRefreshStateRefreshing];
    _rightCollection.header = header;
    [self.rightCollection.header beginRefreshing];
}

- (void)setupFootRefresh{
    
    MJRefreshAutoNormalFooter*footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self footerRereshing];
    }];
    [footer setTitle:@"上拉有惊喜" forState:MJRefreshStateIdle];
    [footer setTitle:@"好了，可以放松一下手指" forState:MJRefreshStatePulling];
    [footer setTitle:@"努力加载中，请稍候" forState:MJRefreshStateRefreshing];
    _rightCollection.footer = footer;
}
#pragma mark - MJRefresh
- (void)headerRereshing{
    [self loadNewRequestWith:YES];
}

- (void)footerRereshing{
    [self loadNewRequestWith:NO];
}

- (void)loadNewRequestWith:(BOOL)isPullRefresh{
    if (isPullRefresh){
        curPage = 1;
        [self.dataArray removeAllObjects];
    }
    NSMutableDictionary *params = [self dictForLoadData];
    [self getCommodityData:params];
}

- (NSMutableDictionary *)dictForLoadData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"tokenKey"] = [AccountTool account].tokenKey;
    if (_keyWord.length>0) {
        params[@"keyword"] = _keyWord;
    }
    params[@"cpage"] = @(curPage);
    if (self.backDict.count>0) {
        [params addEntriesFromDictionary:self.backDict];
    }
    return params;
}
#pragma mark - 信息查找
//通过搜索关键词查找信息
- (void)getCommodityData:(NSMutableDictionary *)params{
    [SVProgressHUD show];
    NSString *url = [NSString stringWithFormat:@"%@modelListPage",baseUrl];
    [BaseApi getGeneralData:^(BaseResponse *response, NSError *error) {
        [self.rightCollection.header endRefreshing];
        [self.rightCollection.footer endRefreshing];
        if ([response.error intValue]==0) {
            [self setupFootRefresh];
            if ([YQObjectBool boolForObject:response.data]){
                [self setupDataWithData:response.data];
                [self setupListDataWithDict:response.data];
                [self.rightCollection reloadData];
                if ([YQObjectBool boolForObject:response.data[@"waitOrderCount"]]) {
                    App;
                    app.shopNum = [response.data[@"waitOrderCount"]intValue];
                    [OrderNumTool orderWithNum:app.shopNum andView:self.orderNumLab];
                }
            }
            [SVProgressHUD dismiss];
        }
    } requestURL:url params:params];
}
//初始化数据
- (void)setupDataWithData:(NSDictionary *)data{
    if([YQObjectBool boolForObject:data[@"model"][@"isShowPrice"]]){
        self.isShowPrice = [data[@"model"][@"isShowPrice"]intValue];
    }
    if([YQObjectBool boolForObject:data[@"typeList"]]){
        self.slideRightTab.goods = [ScreeningInfo
                              objectArrayWithKeyValuesArray:data[@"typeList"]];
    }
//    if (data[@"typeFiler"]||data[@"searchValue"]) {
//        self.screenPop.list = @[data[@"typeFiler"],data[@"searchValue"]];
//    }
    if([YQObjectBool boolForObject:data[@"customList"]]){
        self.popClassView.productList = [DetailTypeInfo
                             objectArrayWithKeyValuesArray:data[@"customList"]];
    }
}
//初始化列表数据
- (void)setupListDataWithDict:(NSDictionary *)data{
    if([YQObjectBool boolForObject:data[@"model"][@"modelList"]]){
        self.rightCollection.footer.state = MJRefreshStateIdle;
        curPage++;
        totalCount = [data[@"model"][@"list_count"]intValue];
        NSArray *seaArr = [ProductInfo objectArrayWithKeyValuesArray:data[@"model"][@"modelList"]];
        [_dataArray addObjectsFromArray:seaArr];
        if(_dataArray.count>=totalCount){
            MJRefreshAutoNormalFooter*footer = (MJRefreshAutoNormalFooter*)self.rightCollection.footer;
            [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
            self.rightCollection.footer.state = MJRefreshStateNoMoreData;
        }
    }else{
        MJRefreshAutoNormalFooter*footer = (MJRefreshAutoNormalFooter*)self.rightCollection.footer;
        [footer setTitle:@"暂时没有商品" forState:MJRefreshStateNoMoreData];
        self.rightCollection.footer.state = MJRefreshStateNoMoreData;
    }
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
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
    CGFloat width = (SDevWidth-(num+1)*5)/num;
    return CGSizeMake(width, width+rowH);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductInfo *info = self.dataArray[indexPath.row];
    CustomProDetailVC *customDeVC = [CustomProDetailVC new];
    customDeVC.proId = info.id;
    [self.navigationController pushViewController:customDeVC animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_searchFie resignFirstResponder];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end