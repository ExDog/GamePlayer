

#import <UIKit/UIKit.h>
#import "HomePageAdsViewsController.h"
#import "HomePageHorizontalList.h"
#import "QBSimpleSyncRefreshControl.h"
#import "GamePlayerAPIClient.h"

@interface HomePageViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,QBRefreshControlDelegate,HomePageHorizontalListDelegate,HttpClientDelegate>{
    HomePageAdsViewsController *_adsView;
    NSMutableArray *itemArray;
    UITableView *tableView;
    NSMutableArray *tebiePlayerList;
    NSMutableArray *remenPlayerList;
    NSMutableArray *zhiyePlayerList;
    NSMutableArray *jieshuoPlayerList;
     NSMutableArray *yulePlayerList;
     NSMutableArray *otherPlayerList;
}
@property (nonatomic, retain) QBSimpleSyncRefreshControl *myRefreshControl;
//@property (nonatomic, retain) UITableView *tableView;
@end
