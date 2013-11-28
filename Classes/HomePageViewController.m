#import "HomePageViewController.h"
#import "HomePageAdsViewsController.h"
#import "HomePageListItem.h"
#import "HomePageHorizontalList.h"
#import "GamePlayerTabBarController.h"
#import "GamePlayerAppDelegate.h"
#import "AFNetworking.h"
#import "EX_Debug.h"
@implementation HomePageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
	//self.view.backgroundColor = [UIColor yellowColor];
    UIImageView *img=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gameplayer_backgroud_0.jpg"]];
    [self.view addSubview:img];
    [img release];
    
    /*
     *测试数据
    HomePageListItem *item1 = [[HomePageListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"channel_test.png.jpg"] text:@"电影1"];
    HomePageListItem *item2 = [[HomePageListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"charts_inside_test1.jpg"] text:@"电影2"];
    HomePageListItem *item3 = [[HomePageListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"charts_inside_test2.jpg"] text:@"电影3"];
    HomePageListItem *item4 = [[HomePageListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"charts_inside_test3.jpg"] text:@"电影4"];
    HomePageListItem *item5 = [[HomePageListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"charts_inside_test4.jpg"] text:@"电影5"];
    HomePageListItem *item6 = [[HomePageListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"charts_inside_test5.jpg"] text:@"电影6"];
    HomePageListItem *item7 = [[HomePageListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"charts_inside_test6.jpg"] text:@"电影7"];
    HomePageListItem *item8 = [[HomePageListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"charts_inside_test7.jpg"] text:@"电影8"];
    HomePageListItem *item9 = [[HomePageListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"charts_inside_test8.jpg"] text:@"电影9"];
    HomePageListItem *item10= [[HomePageListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"charts_inside_test9.jpg"] text:@"电影10"];
    HomePageListItem *item11= [[HomePageListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"9_64x64.png"] text:@"电影11"];
    HomePageListItem *item12= [[HomePageListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"8_64x64.png"] text:@"电影12"];
    HomePageListItem *item13= [[HomePageListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"7_64x64.png"] text:@"电影13"];
    HomePageListItem *item14= [[HomePageListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"6_64x64.png"] text:@"电影14"];
    HomePageListItem *item15= [[HomePageListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"5_64x64.png"] text:@"电影15"];
    */
    /*
    tebiePlayerList = [[NSMutableArray alloc] initWithObjects: item1, item2, item3, item4, item5, nil];
    remenPlayerList = [[NSMutableArray alloc] initWithObjects: item6, item7, item8, item9, item10, nil];
    zhiyePlayerList = [[NSMutableArray alloc] initWithObjects: item11, item12, item13, item14, item15, nil];
     */
    [self getData];
    tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 400) ];
//    [tableView setContentOffset:CGPointMake(0.0, 44.0) animated:NO]; 
    _adsView=[[HomePageAdsViewsController alloc] init];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"exin_background.jpg"]];
    tableView.tableHeaderView=_adsView.view;
//    [GamePlayerTabBarController.LeveyTabBarControllerDelegate];
//    GamePlayerAppDelegate* appDelegate = (GamePlayerAppDelegate*)[UIApplication sharedApplication].delegate;
    QBSimpleSyncRefreshControl *refreshControl = [[QBSimpleSyncRefreshControl alloc] init];
    refreshControl.delegate = self;
    [tableView addSubview:refreshControl];
    self.myRefreshControl = refreshControl;
    [refreshControl release];
    
   [self.view addSubview:tableView];
    [tableView release];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
    title.backgroundColor=[UIColor grayColor];
    if(section==0)
    {
           title.text = @"特别推荐";
    }else if(section==1)
    {
             title.text = @"热门赛事";
    }else if(section==2)
    {
        title.text = @"职业生涯";
    }else if(section==3)
    {
        title.text=@"解说视频";
    }else if(section==4)
    {
        title.text=@"娱乐视频";
    }else if(section==5)
    {
        title.text=@"其他";
    }
    return title;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 155.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
//    NSString *title = @"";
    HomePageHorizontalList *list;
//    if([indexPath row] == 0)
//    {
//        [cell.contentView addSubview:_adsView.view];
//        [_adsView release];
//    }    else
        if ([indexPath section] == 0) {
        list = [[HomePageHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 155.0) title:nil items:tebiePlayerList];
            list.delegate=self;
        [cell.contentView addSubview:list];
    }
    else if ([indexPath section] == 1) {
        list = [[HomePageHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 155.0) title:nil items:remenPlayerList];
         list.delegate=self;
        [cell.contentView addSubview:list];
    }
    else if ([indexPath section] == 2) {
        list = [[HomePageHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 155.0) title:nil items:zhiyePlayerList];
         list.delegate=self;
        [cell.contentView addSubview:list];
    }else if([indexPath section] == 3)
    {
        
    }
    cell.contentView.backgroundColor=[UIColor clearColor];
//    [list setDelegate:self];
    
    
    return cell;
}

#pragma mark  POHorizontalListDelegate

- (void) didSelectItem:(HomePageListItem *)item {
    NSLog(@"Horizontal List Item %@ selected", item.imageTitle); 
}


#pragma mark - QBRefreshControlDelegate

- (void)refreshControlDidBeginRefreshing:(QBRefreshControl *)refreshControl
{
    [self getData];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.myRefreshControl endRefreshing];
    });
}

#pragma httpclient
-(void)GamePlayerAPIClient:(GamePlayerAPIClient *)client didFailWithError:(NSError *)error
{
    
}

-(void)GamePlayerAPIClient:(GamePlayerAPIClient *)client didUpdateWithData:(id)result
{
    NSLog(@"result:::::::::%@::::::::::::::",result);
    NSArray *results=result;
    NSLog(@"aa%@",[[results objectAtIndex:0] objectForKey:@"pageName"]);
}

-(void)getData
{
    [GamePlayerAPIClient sharedClient].delegate=self;
    [[GamePlayerAPIClient sharedClient] getData:@"/home" withParameter:nil];
}
@end
