#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;//安全self
#define IS_IOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define IS_IOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
#define DF_IOS7 (IS_IOS7*20)
//判断系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#define REQUEST_CALLBACK void (^)(BaseResponse *response, NSError *error)
//new
#define App AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate
#define Defs  [NSUserDefaults standardUserDefaults]
#define HomeDir [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

//<<<---  屏幕适配相关
#define IsPhone ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define iOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#define SDevWidth  [UIScreen mainScreen].bounds.size.width
#define SDevHeight  [UIScreen mainScreen].bounds.size.height
#define DevWidth  (IsPhone ? [UIScreen mainScreen].bounds.size.width:[UIScreen mainScreen].bounds.size.height)
#define DevHeight  (IsPhone ?[UIScreen mainScreen].bounds.size.height:[UIScreen mainScreen].bounds.size.width)
#define IS_6PLUS (IsPhone && [[UIScreen mainScreen] bounds].size.height >= 736.0)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

//<<<--- DataBase相关
#define DBPath [HomeDir stringByAppendingString:@"/Data.sqlite"]
#define DB [FMDatabase databaseWithPath:DBPath]
//--->>>
#define CURRENT_LANAGES  @"CURRENT_LANAGES"
#define SAVE_INFO_TO_LOCAL @"SAVE_INFO_TO_LOCAL"
#define STAY_SINGED_IN @"STAY_SINGED_IN"

#define LAUNCHIMG_SLEEP_TIME 1.0f
#define CHINESE @"zh-Hans"
#define ENGLISH @"en"
#define ECLocalizedString(key,mytable) [[ECLocalizableController bundle] localizedStringForKey:(key) value:(key) table:(mytable)]
#define MYTABLE @"InfoPlist"
#define kRequestTimeOutInterval 10
#define SERVER_REQUEST_ERROR 1000000
#define SHOWALERTVIEW(msg)   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];[alertView show];
//颜色相关
#define CUSTOM_COLOR(a,b,c) [UIColor colorWithRed:a/255.0f green:b/255.0f blue:c/255.0f alpha:1]
#define CUSTOM_COLOR_ALPHA(a,b,c,d) [UIColor colorWithRed:a/255.0f green:b/255.0f blue:c/255.0f alpha:d]
#define MAIN_COLOR CUSTOM_COLOR(239, 132, 92)
#define MAINText_COLOR CUSTOM_COLOR(241,43,49)
#define DefaultColor CUSTOM_COLOR(240,239,245)
#define BarColor CUSTOM_COLOR(245,245,247)
#define BordColor CUSTOM_COLOR(218,218,218)
//基础接口
#define baseNet @"http://appapi2.fanerweb.com/api/"
//网络接口
#define baseUrl [NSString stringWithFormat:@"%@aproxy/",baseNet]
//支付宝支付网址
#define ZFBStonePay [NSString stringWithFormat:@"%@Payment/GetAilpayStoneOrderPayStr",baseNet]
#define ZFBPay [NSString stringWithFormat:@"%@Payment/GetAilpayModelOrderPayStr",baseNet]
//微信支付网址
#define WXStonePay [NSString stringWithFormat:@"%@Payment/GetWxpayStoneParameter",baseNet]
#define WXPay [NSString stringWithFormat:@"%@Payment/GetWxpayModelParameter",baseNet]
/**选择地址通知名字*/
#define NotificationName @"NotificationChangeCity"
#define UserInfoName @"userinfoCityName"
/**选择裸钻通知名字*/
#define NotificationDriName @"NotificationChangeDri"
#define UserInfoDriName @"userinfoDriName"
/**管理地址通知*/
#define NotificationCaseType @"NotificationManagerCaseType"
#define UserInfoCaseType @"UserinfoManagerCaseType"
/**信息条数通知*/
#define NotificationList @"NotificationList"
#define ListNum @"UserinfoList"
#define appVer [NSString stringWithFormat:@"i %@ 002",[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]]
//默认图片
#define DefaultImage [UIImage imageNamed:@"iosDefalut"]
//iosDefalut anios
typedef enum{
    UIImageSplitType80 = 80,
    UIImageSplitType160 = 160,
    UIImageSplitType480 = 480,
    UIImageSplitType640 = 640
} UIImageSplitType;
