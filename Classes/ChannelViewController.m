

#import "GamePlayerAppDelegate.h"
#import "ChannelViewController.h"
#import "GamePlayerTabBarController.h"
#import "HomePageViewController.h"
#import "ChannelListView.h"
#define start_color [UIColor colorWithHex:0xEEEEEE]
#define end_color [UIColor colorWithHex:0xDEDEDE]
@implementation ChannelViewController


- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

}

-(void)loadView
{
    [super loadView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    self.tableView.rowHeight = 60;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"exin_background.jpg"]];
     [self.view addSubview:self.tableView];
}


- (void)hide
{
    static NSInteger dir = 0;
    
    HomePageViewController *firstVC = [[HomePageViewController alloc] init];
    
    //firstVC.hidesBottomBarWhenPushed = YES;
    GamePlayerAppDelegate* appDelegate = (GamePlayerAppDelegate*)[UIApplication sharedApplication].delegate;

    dir++;
    appDelegate.leveyTabBarController.animateDriect = dir % 2;
    firstVC.hidesBottomBarWhenPushed = YES;
    //[appDelegate.leveyTabBarController hidesTabBar:YES animated:YES]; 
    [self.navigationController pushViewController:firstVC animated:YES];
    [firstVC release];
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return tableView.rowHeight + [PrettyTableViewCell tableView:tableView neededHeightForIndexPath:indexPath];
    return  100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    UIImageView *item1= [[UIImageView alloc]initWithImage:
                         [UIImage imageNamed:@"search_add_icon"]];
    [item1 setContentMode:UIViewContentModeCenter];
    UIImageView *item2= [[UIImageView alloc]initWithImage:
                         [UIImage imageNamed:@"search_add_icon"]];
    [item2 setContentMode:UIViewContentModeCenter];
    UIImageView *item3= [[UIImageView alloc]initWithImage:
                         [UIImage imageNamed:@"search_add_icon"]];
    [item3 setContentMode:UIViewContentModeCenter];
    UIImageView *item4= [[UIImageView alloc]initWithImage:
                         [UIImage imageNamed:@"search_add_icon"]];
    [item4 setContentMode:UIViewContentModeCenter];
  NSMutableArray *content=[[NSMutableArray alloc] initWithObjects: item1, item2, item3, item4, nil];

    ChannelListView *list;
    if ([indexPath section] == 0) {
        list = [[ChannelListView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 155.0) title:nil items:content];
        [cell.contentView addSubview:list];
    }

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didselectRowAtindexPath");
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (void) didSelectItem:(UIImageView *)item {
    NSLog(@"aaaaaaaaaselected");
}
@end
