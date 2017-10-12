//
//  InformationVC.m
//  MillenniumStarERP
//
//  Created by yjq on 16/9/5.
//  Copyright © 2016年 com.millenniumStar. All rights reserved.
//

#import "InformationVC.h"
#import "InformationCell.h"
#import "MessageInfo.h"
#import "ZBButten.h"
@interface InformationVC ()<UIWebViewDelegate,UINavigationControllerDelegate>
@property (weak,  nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,  copy) NSArray *listArr;
@property (nonatomic,  copy) NSString *url;
@property (nonatomic,  weak) UIButton *backBtn;
@end

@implementation InformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    _webView.scrollView.bounces = NO;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.delegate = self;
    
    self.url = @"http://appapi2.fanerweb.com/html/pages/ds/";
    NSURLRequest *urlRe = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:urlRe];
    self.navigationController.delegate = self;
    [self creatNaviBtn];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
    BOOL isBack = [webView canGoBack];
    self.backBtn.hidden = !isBack;
}

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
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
    btn.hidden = YES;
    self.backBtn = btn;
}

- (void)backClick{
    if ([_webView canGoBack]) {
        [_webView goBack];
        return;
    }
    [MBProgressHUD showError:@"已经是最上层了"];
}

//- (void)setBaseViewData{
//    self.tableView = [[UITableView alloc]init];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
//    [self.view addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(0);
//        make.left.equalTo(self.view).offset(0);
//        make.right.equalTo(self.view).offset(0);
//        make.bottom.equalTo(self.view).offset(0);
//    }];
//}
//
//- (void)loadInfoData{
//    NSString *regiUrl = [NSString stringWithFormat:@"%@userMessagePageList",baseUrl];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"tokenKey"] = [AccountTool account].tokenKey;
//    params[@"cpage"] = @1;
//    [BaseApi getGeneralData:^(BaseResponse *response, NSError *error) {
//        if ([response.error intValue]==0) {
//            self.listArr = [MessageInfo objectArrayWithKeyValuesArray:response.data[@"messageList"]];
//            [self.tableView reloadData];
//        }else{
//            SHOWALERTVIEW(response.message);
//        }
//        [SVProgressHUD dismiss];
//    } requestURL:regiUrl params:params];
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.listArr.count;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 80;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    InformationCell *infoCell = [InformationCell cellWithTableView:tableView];
//    MessageInfo *info = self.listArr[indexPath.row];
//    infoCell.messInfo = info;
//    return infoCell;
//}

@end
