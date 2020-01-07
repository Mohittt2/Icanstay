//
//  PackagesViewController.m
//  ICanStay
//
//  Created by Planet on 5/2/17.
//  Copyright © 2017 verticallogics. All rights reserved.
//

#import "PackagesViewController.h"
#import "NotificationScreen.h"
#import "DashboardScreen.h"
#import "SideMenuController.h"
#import "HomeScreenController.h"

@interface PackagesViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIView         *topWhiteBaseView;
@property (nonatomic, strong) UIWebView      *packageWebView;
@property (nonatomic, strong) UIButton       *backButton;
@property (nonatomic, strong) UIButton       *notificationButton;
@property (nonatomic, strong) UIImageView    *logoIconImgView;
@property(nonatomic)          BOOL            pageLoaded;
@end

@implementation PackagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _pageLoaded = NO;
     CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    

    self.packageWebView = [[UIWebView alloc] init];     NSString *url=@"http://www.icanstay.com/packages?inapp=1";
    NSURL *nsurl=[NSURL URLWithString:url];
    self.packageWebView.delegate = self;
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [self.packageWebView loadRequest:nsrequest];
    self.packageWebView.scrollView.bounces = NO;
    
    [self.view addSubview:self.packageWebView];
    self.packageWebView.delegate = self;
    
    ICSingletonManager *globals = [ICSingletonManager sharedManager];
    if ([globals.isFromHomeScreenToPackageScreen isEqualToString:@"YES"]) {
        self.packageWebView.frame = CGRectMake(0, - 30, screenRect.size.width, screenRect.size.height + 30);
    }else {
      self.packageWebView.frame = CGRectMake(0, -10, screenRect.size.width, screenRect.size.height +10 );

    }

 
   
    self.topWhiteBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,screenRect.size.width , 64)];
    self.topWhiteBaseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topWhiteBaseView];
    
    self.notificationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.notificationButton.frame = CGRectMake(self.topWhiteBaseView.frame.size.width - 40 - 10, 20, 24, 24);
    [self.notificationButton setBackgroundImage:[UIImage imageNamed:@"notification1"] forState:UIControlStateNormal];
    [self.notificationButton addTarget:self action:@selector(notificationButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.topWhiteBaseView addSubview:self.notificationButton];
    
    self.logoIconImgView = [[UIImageView alloc]initWithFrame:CGRectMake((self.topWhiteBaseView.frame.size.width - 150)/2, 15, 150, 34)];
    self.logoIconImgView.image = [UIImage imageNamed:@"topBanner"];
     self.logoIconImgView.userInteractionEnabled = YES;
    [self.topWhiteBaseView addSubview:self.logoIconImgView];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.topWhiteBaseView addGestureRecognizer:singleFingerTap];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.backButton.frame = CGRectMake(20, 22, 30, 20);
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"back_arrow"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.topWhiteBaseView addSubview:self.backButton];

     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Do any additional setup after loading the view.
}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    HomeScreenController *vcHomeScreen = [storyboard instantiateViewControllerWithIdentifier:@"HomeScreenController"];
    SideMenuController *vcSideMenu =     [storyboard instantiateViewControllerWithIdentifier:@"SideMenuController"];
    
    MMDrawerController *drawerController = [[MMDrawerController alloc]initWithCenterViewController:vcHomeScreen
                                                                          leftDrawerViewController:vcSideMenu];
    [drawerController setRestorationIdentifier:@"MMDrawer"];
    
    
    [drawerController setMaximumLeftDrawerWidth:SCREEN_WIDTH*2/3];
    
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    drawerController.shouldStretchDrawer = NO;
    
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:drawerController];
    [navController setNavigationBarHidden:YES];
    [self.view.window setRootViewController:navController];
    [self.view.window makeKeyAndVisible];
    
    
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationPortrait) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
            
        }else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
                   }
        
    }else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
           
        }else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            
                   }
    }
    
}
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
  
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationPortrait) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
            
        }else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
          
            self.topWhiteBaseView.frame =  CGRectMake(0, 0,screenRect.size.width , 100);
            self.backButton.frame      = CGRectMake(10, 37, 40, 25);
            self.notificationButton.frame =          CGRectMake(self.topWhiteBaseView.frame.size.width - 40 - 10, 37, 25, 25);
            self.logoIconImgView.frame = CGRectMake((self.topWhiteBaseView.frame.size.width - 150)/2, 15, 150, 70);
            self.packageWebView.frame = CGRectMake(0, self.topWhiteBaseView.frame.origin.y + self.topWhiteBaseView.frame.size.height, screenRect.size.width, screenRect.size.height - 100);
        }
        
    }else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
        }else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            self.topWhiteBaseView.frame =  CGRectMake(0, 0,screenRect.size.width , 100);
            self.backButton.frame      = CGRectMake(10, 37, 40, 25);
            self.notificationButton.frame =          CGRectMake(self.topWhiteBaseView.frame.size.width - 40 - 10, 37, 25, 25);
            self.logoIconImgView.frame = CGRectMake((self.topWhiteBaseView.frame.size.width - 150)/2, 15, 150, 70);
            self.packageWebView.frame = CGRectMake(0, self.topWhiteBaseView.frame.origin.y + self.topWhiteBaseView.frame.size.height, screenRect.size.width, screenRect.size.height - 100);
        }
    }

}
- (IBAction)notificationBtnPressed:(id)sender {
}
- (IBAction)backBtnMenuPressed:(id)sender {
}
-(void)backButtonTapped:(id)sender
{
    ICSingletonManager *globals = [ICSingletonManager sharedManager];
    if ([globals.isFromDeepLinkToPackageScreen isEqualToString:@"YES"]) {
        globals.isFromDeepLinkToPackageScreen = @"NO";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        HomeScreenController *vcHomeScreen = [storyboard instantiateViewControllerWithIdentifier:@"HomeScreenController"];
        SideMenuController *vcSideMenu =     [storyboard instantiateViewControllerWithIdentifier:@"SideMenuController"];
        
        MMDrawerController *drawerController = [[MMDrawerController alloc]initWithCenterViewController:vcHomeScreen
                                                                              leftDrawerViewController:vcSideMenu];
        [drawerController setRestorationIdentifier:@"MMDrawer"];
        
        
        [drawerController setMaximumLeftDrawerWidth:SCREEN_WIDTH*2/3];
        
        [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        drawerController.shouldStretchDrawer = NO;
        
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:drawerController];
        [navController setNavigationBarHidden:YES];
        [self.view.window setRootViewController:navController];
        [self.view.window makeKeyAndVisible];
        
    }else if ([self.packageWebView canGoBack]) {
        [self.packageWebView goBack];
    }else if ([globals.isFromHomeScreenToPackageScreen isEqualToString:@"YES"]){
        globals.isFromHomeScreenToPackageScreen = @"NO";
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if (globals.isFromMenu){
        
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }
   }
-(void)notificationButtonTapped:(id)sender
{
    LoginManager *login = [[LoginManager alloc]init];
    if ([[login isUserLoggedIn] count]>0)
    {
        ICSingletonManager *globals = [ICSingletonManager sharedManager];
        globals.isWithoutLoginNoti = false;
        NotificationScreen *notification = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationScreen"];
        [self.navigationController pushViewController:notification animated:YES];
        
        
        //        NotificationViewController *notification = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationViewController"];
        //        [self.navigationController pushViewController:notification animated:YES];
        
        
    }
    else
    {
        ICSingletonManager *globals = [ICSingletonManager sharedManager];
        globals.isWithoutLoginNoti = true;
        [self switchToLoginScreen];
    }

}
- (void)pushToDashBoardScreenAfterLoggingIn
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    DashboardScreen *dashboardScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"DashboardScreen"];
    [self.mm_drawerController setCenterViewController:dashboardScreen withCloseAnimation:NO completion:nil];
}
- (void)switchToLoginScreen
{
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(pushToDashBoardScreenAfterLoggingIn) name:kSwitchToDashBoardScreen object:nil];
    ICSingletonManager *globals = [ICSingletonManager sharedManager];
    globals.isFromMenu = false;
    
    LoginScreen *vcLogin = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginScreen"];
    [self.navigationController pushViewController:vcLogin animated:YES];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
   //    BOOL isInstalled = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"whatsapp://"]];
//    
//    if (isInstalled) {
//        
//    } else {
//        
//        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/in/app/whatsapp-messenger/id310633997?mt=8"];
//        
//        if (![[UIApplication sharedApplication] openURL:url]) {
//            NSLog(@"%@%@",@"Failed to open url:",[url description]);
//            
//            
//        }
//        
//    }
    
 NSURL * currentURL = self.packageWebView.request.URL;
    NSLog(@"%@", currentURL);
    
   }

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL * currentURL = self.packageWebView.request.URL;
    NSLog(@"%@", currentURL);
    
    if( request.URL != nil && [[request.URL absoluteString] hasPrefix:@"whatsapp://"]) {
        // do stuff
        NSLog(@"wahtssup installed");
        NSLog(@"inside Webview");
        BOOL isInstalled = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"whatsapp://"]];
        
        if (isInstalled) {
            
        } else {
//            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"whatsapp://"]]) {
//                // Safe to launch the facebook app
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/in/app/whatsapp-messenger/id310633997?mt=8"]];
//            }
            
            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/in/app/whatsapp-messenger/id310633997?mt=8"];
            
            if (![[UIApplication sharedApplication] openURL:url]) {
                NSLog(@"%@%@",@"Failed to open url:",[url description]);
            }
            
                
//                [self.navigationController popViewControllerAnimated:YES];
//                
//                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//                
//                HomeScreenController *vcHomeScreen = [storyboard instantiateViewControllerWithIdentifier:@"HomeScreenController"];
//                SideMenuController *vcSideMenu =     [storyboard instantiateViewControllerWithIdentifier:@"SideMenuController"];
//                
//                MMDrawerController *drawerController = [[MMDrawerController alloc]initWithCenterViewController:vcHomeScreen
//                                                                                      leftDrawerViewController:vcSideMenu];
//                [drawerController setRestorationIdentifier:@"MMDrawer"];
//            
//                [drawerController setMaximumLeftDrawerWidth:SCREEN_WIDTH*2/3];
//                
//                [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
//                [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
//                drawerController.shouldStretchDrawer = NO;
//                
//                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:drawerController];
//                [navController setNavigationBarHidden:YES];
//                [self.view.window setRootViewController:navController];
//                [self.view.window makeKeyAndVisible];
            if ([self.packageWebView canGoBack]) {
                [self.packageWebView goBack];
            }       
            
           }
        return NO;
    }else{
        NSLog(@"wahtssup not installed");
    }

   return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSURL * currentURL = self.packageWebView.request.URL;
    NSLog(@"%@", currentURL);
    self.pageLoaded = YES;
 }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end