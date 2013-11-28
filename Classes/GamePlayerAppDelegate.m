

#import "GamePlayerAppDelegate.h"
#import "HomePageViewController.h"
#import "ChannelViewController.h"
#import "GamePlayerTabBarController.h"
#import "RankingCollectionViewController.h"
#import "MineSettingViewController.h"
#import "UserGuideViewController.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "EXConstants.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "GamePlayerAPIClient.h"
//#import "RootViewController.h"
@implementation GamePlayerAppDelegate

@synthesize window;
@synthesize leveyTabBarController;


#pragma mark -
#pragma mark Application lifecycle


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
      [self initUserSetting];
    //判断是不是第一次启动应用
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        NSLog(@"第一次启动");
        //如果是第一次启动的话,使用UserGuideViewController (用户引导页面) 作为根视图
        UserGuideViewController *userGuideViewController = [[UserGuideViewController alloc] init];
        self.window.rootViewController = userGuideViewController;
        [userGuideViewController release];
    }
    else
    {
        [self start];
    }
     [self.window makeKeyAndVisible];
    return YES;
}

//初始化用户设置
-(void)initUserSetting
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *server= [defaults stringForKey:@"server"];
    NSString *port = [defaults stringForKey:@"port"];
    NSString *switchStyle = [defaults stringForKey:@"switchStyle"];
    if ([server length]==0) {
        server = @"127.0.0.1";
    }
    if ([port length]==0) {
        port = @"3000";
    }
    if ([switchStyle intValue]) {
        switchStyle = @"1";
    }
    else{
        switchStyle = @"0";
    }
  SERVER = [NSString stringWithFormat:@"http://%@:%@",server,port];
}

//开始进入主界面
-(void)start
{
    [self initDockBarImg ];
    
    [self initDockBarControl];
    
    leveyTabBarController = [[GamePlayerTabBarController alloc] initWithViewControllers:dockBarCtrArr imageArray:dockBarImgArr];
	[leveyTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"c-2-1.png"]];
	[leveyTabBarController setTabBarTransparent:YES];
    UINavigationController *tbNc = [[UINavigationController alloc] initWithRootViewController:leveyTabBarController];
	tbNc.delegate = self;
    self.window.rootViewController=tbNc;
}

//初始化dockbar的图标
-(void)initDockBarImg
{
    NSMutableDictionary *imgDic = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic setObject:[UIImage imageNamed:@"001_1.png"] forKey:@"Default"];
	[imgDic setObject:[UIImage imageNamed:@"001.png"] forKey:@"Highlighted"];
	[imgDic setObject:[UIImage imageNamed:@"001.png"] forKey:@"Seleted"];
	NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic2 setObject:[UIImage imageNamed:@"002_2.png"] forKey:@"Default"];
	[imgDic2 setObject:[UIImage imageNamed:@"002.png"] forKey:@"Highlighted"];
	[imgDic2 setObject:[UIImage imageNamed:@"002.png"] forKey:@"Seleted"];
	NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic3 setObject:[UIImage imageNamed:@"003_3.png"] forKey:@"Default"];
	[imgDic3 setObject:[UIImage imageNamed:@"003.png"] forKey:@"Highlighted"];
	[imgDic3 setObject:[UIImage imageNamed:@"003.png"] forKey:@"Seleted"];
	NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic4 setObject:[UIImage imageNamed:@"004_4.png"] forKey:@"Default"];
	[imgDic4 setObject:[UIImage imageNamed:@"004.png"] forKey:@"Highlighted"];
	[imgDic4 setObject:[UIImage imageNamed:@"004.png"] forKey:@"Seleted"];
	dockBarImgArr= [NSArray arrayWithObjects:imgDic,imgDic2,imgDic3,imgDic4,nil];
}

//初始化dock的control
-(void)initDockBarControl
{
      HomePageViewController *firstVC = [[HomePageViewController alloc] init];
	 ChannelViewController *secondVC = [[ChannelViewController alloc] init];
     RankingCollectionViewController  *thirdVC = [[RankingCollectionViewController alloc] init];
	 MineSettingViewController *fourthVC = [[MineSettingViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:secondVC];
	nc.delegate = self;
	[secondVC release];
	dockBarCtrArr= [NSArray arrayWithObjects:firstVC,secondVC,thirdVC,fourthVC,nil];
	[firstVC release];
	[nc release];
	[thirdVC release];
	[fourthVC release];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController.hidesBottomBarWhenPushed)
    {
        [leveyTabBarController hidesTabBar:YES animated:YES]; 
    }
    else
    {
        [leveyTabBarController hidesTabBar:NO animated:YES]; 
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}



- (void)dealloc {
    [leveyTabBarController release];
    [window release];
    [super dealloc];
}

@end
