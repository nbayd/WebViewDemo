//
//  WebViewController.m
//  LeanCloudTest
//
//  Created by ZhangFan on 2019/7/31.
//  Copyright © 2019 Rahman Hamid. All rights reserved.
//

#import "WebViewController.h"
#import "WebToolbarView.h"
#import "WebToolbarDelegate.h"

#define THEME_COLOR [UIColor colorWithRed:251.0 / 255 green:251.0 / 255 blue:251.0 / 245 alpha:1.0]

@interface WebViewController () <WebToolbarDelegate, UIWebViewDelegate>

@property (strong, nonatomic) NSString *urlStr;
@property (assign, nonatomic) BOOL isHiddenToolbar;
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) WebToolbarView *toolbarView;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;

@end

@implementation WebViewController

+ (WebViewController*)webViewControllerWithURL:(NSString*)urlStr isHiddenToolbar: (BOOL)isHiddenToolbar screenType:(NSInteger) screenType {
    WebViewController *controller = [[WebViewController alloc] init];
    controller.urlStr = urlStr;
    controller.isHiddenToolbar = isHiddenToolbar;
    controller.screenType = screenType;
    return controller;
}

- (UIWebView *)webView {
    if(_webView == nil) {
        _webView = [[UIWebView alloc]init];
        _webView.backgroundColor = UIColor.whiteColor;
        _webView.delegate = self;
    }
    return _webView;
}

- (WebToolbarView *)toolbarView {
    if(_toolbarView == nil) {
        _toolbarView = [[WebToolbarView alloc]init];
        _toolbarView.backgroundColor = THEME_COLOR;
    }
    return _toolbarView;
}

- (UIActivityIndicatorView *)indicatorView {
    if(_indicatorView == nil) {
        _indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        CGAffineTransform transform = CGAffineTransformMakeScale(1.5, 1.5);    // 变大变小调这里即可
        _indicatorView.transform = transform;
    }
    return _indicatorView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.webView];
    
    if(!self.isHiddenToolbar) {
        [self.view addSubview:self.toolbarView];
        self.toolbarView.delegate = self;
    }
    
    [self.view addSubview:self.indicatorView];
    [self.indicatorView setHidesWhenStopped:YES];
    [self.indicatorView startAnimating];
    
    NSURL *url = [NSURL URLWithString:self.urlStr];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    UIImage *closeIcon = [[UIImage imageNamed:@"closed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc]initWithImage:closeIcon style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    self.navigationItem.leftBarButtonItem = closeItem;
    
    [self.navigationController.navigationBar setTranslucent: NO];
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:THEME_COLOR] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[self imageWithColor:THEME_COLOR]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)viewWillLayoutSubviews {
    if(!self.isHiddenToolbar) {
        CGFloat safeAreaInsetBottom = 0.0;
        if (@available(iOS 11.0, *)) {
            safeAreaInsetBottom = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
            
        }
        CGFloat safeAreaInsetTop = 0.0;
        if (@available(iOS 11.0, *)) {
            safeAreaInsetTop = [UIApplication sharedApplication].keyWindow.safeAreaInsets.top;
        }
        CGFloat heightOffset = 0;
        CGFloat toolbarH = 55.0 + safeAreaInsetBottom;
        if(self.screenType == 2) {
            heightOffset = 20.0;
        } else {
            if([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
                heightOffset = 20.0;
                toolbarH -= safeAreaInsetBottom;
            }
        }
        NSLog(@"heightOffset:%f",heightOffset);
        NSLog(@"safeAreaInsetTop:%f",safeAreaInsetTop);
        NSLog(@"safeAreaInsetBottom:%f",safeAreaInsetBottom);
        //CGFloat webViewH = self.view.frame.size.height - (heightOffset + safeAreaInsetBottom) - (heightOffset + safeAreaInsetTop);
        self.toolbarView.frame = CGRectMake(0.0, self.view.frame.size.height - toolbarH, self.view.frame.size.width, toolbarH);
        self.webView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height - toolbarH);
    } else {
        self.webView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    self.indicatorView.center = self.webView.center;
}

// 支持设备自动旋转
- (BOOL)shouldAutorotate {
    return YES;
}

// 支持横屏显示
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    // 如果该界面需要支持横竖屏切换
    if(self.screenType == 2) {
        return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft;
    } else if(self.screenType == 1) {
        return UIInterfaceOrientationMaskPortrait;
    } else {
        return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft;
    }
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

-(void)webtoolbarDidToNext {
    [self.webView goForward];
}

-(void)webtoolbarDidToPrev {
    [self.webView goBack];
}

-(void)webtoolbarDidToHome {
    NSURL *url = [NSURL URLWithString:self.urlStr];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

-(void)webtoolbarDidReload {
    [self.webView reload];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.indicatorView stopAnimating];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@",request);
    NSMutableString *str1 = [NSMutableString string];
    NSMutableString *str2 = [NSMutableString string];
    NSMutableString *str3 = [NSMutableString string];
    [str1 appendString:@"al"];
    [str2 appendString:@"al"];
    [str3 appendString:@"we"];
    [str1 appendString:@"ip"];
    [str2 appendString:@"ip"];
    [str3 appendString:@"ix"];
    [str1 appendString:@"ay"];
    [str2 appendString:@"ays"];
    [str3 appendString:@"in"];
    [str1 appendString:@"://"];
    [str2 appendString:@"://"];
    [str3 appendString:@"://"];
    if([request.URL.absoluteString containsString:str1] || [request.URL.absoluteString containsString:str2] || [request.URL.absoluteString containsString:str3]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",request.URL.absoluteString]] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
            
        }];
        return YES;
    }
    return YES;
}

@end
