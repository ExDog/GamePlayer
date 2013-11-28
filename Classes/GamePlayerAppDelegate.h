
#import <UIKit/UIKit.h>

@class GamePlayerTabBarController;

@interface GamePlayerAppDelegate : NSObject <UIApplicationDelegate, UINavigationControllerDelegate> {
    UIWindow *window;
    GamePlayerTabBarController *leveyTabBarController;
    NSArray *dockBarImgArr;  //dockBar 中的图标数组
    NSArray *dockBarCtrArr;   //dockBar 点击图标后每个controlview的数组
}

@property (nonatomic,assign) int currentCtr;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GamePlayerTabBarController *leveyTabBarController;
-(void)start;
-(void)getDataWithJsonAt:(NSString*)urlString AndParams:(NSDictionary*)params;

@end

