

#import "RankingCollectionViewController.h"
#import "RankingItem.h"
@interface RankingCollectionViewController ()

//界面基本参数
- (void) setNavBar;
- (void) backAction;
- (void) addBasicView;

//左右滑动相关
- (void)initScrollView;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)createAllEmptyPagesForScrollView;

//界面按钮事件
- (void) btnActionShow;
- (void) realRankingButtonAction;
-(void)allRankingButtonAction;
- (void) sevenRankingButtonAction;

@end

@implementation RankingCollectionViewController

@synthesize realRankingButton;
@synthesize sevenPassRankingButton;
@synthesize allRankingButton;
@synthesize slidLabel;
@synthesize nibScrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor blackColor];
     slidLabel=[[UILabel alloc]init];
    slidLabel.backgroundColor=[UIColor blueColor];
    [self setNavBar];
    
    [self addBasicView];
    
    [self initScrollView];
    [self.view setFrame:CGRectMake(0, 0, 320, 460)];
     slidLabel.frame = CGRectMake(10, 26, 100, 4);
    [self.view addSubview:realRankingButton];
    [self.view addSubview:sevenPassRankingButton];
    [self.view addSubview:allRankingButton];
    [self.view addSubview:slidLabel];
    [self.view addSubview:nibScrollView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [realRankingButton release];
    [sevenPassRankingButton release];
    [allRankingButton release];
    [slidLabel release];
    [nibScrollView release];
    [super dealloc];
}

#pragma mark-
#pragma mark navigationController Methods

- (void) setNavBar
{
    //    self.navigationController.navigationBarHidden = NO;//显示nav，这里使用动画
    [self.navigationController  setNavigationBarHidden:NO animated:YES];
    
    //设置Navigation Bar颜色
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(30/255.0) green:(175/255.0) blue:(200/255.0) alpha:1];
    
    self.title = @"新浪微博:BT_ZA";
    
    UIButton *BackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 164.0, 45, 45)];
	[BackBtn setImage:[UIImage imageNamed:@"btn_back1.png"]  forState:UIControlStateNormal];
	[BackBtn setImage:[UIImage imageNamed:@"btn_back2"] forState:UIControlStateHighlighted];
	BackBtn.backgroundColor = [UIColor clearColor];
	[BackBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:BackBtn];
	temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
	self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
    
}

- (void) backAction
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void) addBasicView
{
    realRankingButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 0, 100, 30)];
    realRankingButton.backgroundColor=[UIColor grayColor];
    realRankingButton.showsTouchWhenHighlighted = YES;  //指定按钮被按下时发光
    
//    [realRankingButton setTitle:@"实事" forState:UICollectionViewScrollPositionTop];
    [realRankingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//此时选中
    [realRankingButton addTarget:self action:@selector(realRankingButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    sevenPassRankingButton=[[UIButton alloc]initWithFrame:CGRectMake(110, 0, 100, 30)];
    sevenPassRankingButton.backgroundColor=[UIColor grayColor];
    sevenPassRankingButton.showsTouchWhenHighlighted = YES;  //指定按钮被按下时发光
    [sevenPassRankingButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];//此时未被选中
    [sevenPassRankingButton addTarget:self action:@selector(sevenRankingButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    allRankingButton=[[UIButton alloc]initWithFrame:CGRectMake(210, 0, 100, 30)];
    allRankingButton.backgroundColor=[UIColor grayColor];
    allRankingButton.showsTouchWhenHighlighted = YES;  //指定按钮被按下时发光
    [allRankingButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];//此时未被选中
    [allRankingButton addTarget:self action:@selector(allRankingButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark-
#pragma mark 界面按钮事件

- (void) btnActionShow
{
    if (currentPage == 0) {
        [self realRankingButtonAction];
    }
    else if(currentPage==1){
        [self sevenRankingButtonAction];
    }else if(currentPage==2){
          [self allRankingButtonAction];
    }
}

- (void) realRankingButtonAction
{
    [realRankingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//此时选中
    [sevenPassRankingButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];//此时未被选中
    
    [UIView beginAnimations:nil context:nil];//动画开始    
    [UIView setAnimationDuration:0.3];
    slidLabel.frame = CGRectMake(10, 26, 100, 4);
    [nibScrollView setContentOffset:CGPointMake(320*0, 0)];//页面滑动
    
    [UIView commitAnimations];
}

- (void) sevenRankingButtonAction
{
    [sevenPassRankingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//此时选中
    [realRankingButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];//此时未被选中
    
    [UIView beginAnimations:nil context:nil];//动画开始
    [UIView setAnimationDuration:0.3];
    
    slidLabel.frame = CGRectMake(110, 26, 100, 4);
    [nibScrollView setContentOffset:CGPointMake(320*1, 0)];
    
    [UIView commitAnimations];
}

- (void) allRankingButtonAction
{
    [sevenPassRankingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//此时选中
    [realRankingButton setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];//此时未被选中
    
    [UIView beginAnimations:nil context:nil];//动画开始
    [UIView setAnimationDuration:0.3];
    
    slidLabel.frame = CGRectMake(210, 26, 100, 4);
    [nibScrollView setContentOffset:CGPointMake(320*2, 0)];
    
    [UIView commitAnimations];
}
//表视图委托
#pragma mark -
#pragma mark table view data source methods

//返回某个表视图有多少行数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == realRankingTableView) {
        return couponArry.count;
    }
    else if(tableView==senvenHisRankingTableView){
        return groupbuyArry.count;
    }else if(tableView==allRankingTableView)
    {
        return 5;
    }
    return 0;
}

//表视图显示表视图项时调用：第一次显示（根据视图大小显示多少个视图项就调用多少次）以及拖动时调用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier: CellIdentifier] autorelease];
    }else{
        //cell中本来就有一个subview，如果是重用cell，则把cell中自己添加的subview清除掉，避免出现重叠问题
        //         [[cell.subviews objectAtIndex:1] removeFromSuperview];
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
    }
    
    if (tableView == realRankingTableView) {
        //实事纪录
        [cell.contentView addSubview:[[RankingItem alloc]initWithFrame:CGRectMake(0, 0, 320, 100) image:[UIImage imageNamed:@"homepage_test4.jpg"] text:@"adasdasdasdsdada"] ];
//        cell.textLabel.text = [NSString stringWithFormat:@"%@", [couponArry objectAtIndex:indexPath.row]];
    }
    else if(tableView == senvenHisRankingTableView){
        //七天内播放纪录
            [cell.contentView addSubview:[[RankingItem alloc]initWithFrame:CGRectMake(0, 0, 320, 100) image:[UIImage imageNamed:@"charts_test1.jpg"] text:@"adasdasdasdsdada"] ];
//        cell.textLabel.text = [NSString stringWithFormat:@"%@", [groupbuyArry objectAtIndex:indexPath.row]];
    }else{
            [cell.contentView addSubview:[[RankingItem alloc]initWithFrame:CGRectMake(0, 0, 320, 100) image:[UIImage imageNamed:@"homepage_test7.jpg"] text:@"adasdasdasdsdada"] ];
//             cell.textLabel.text = [NSString stringWithFormat:@"%@", [couponArry objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

//数据源委托
#pragma mark -
#pragma mark table delegate methods

//在某行被选中前调用，返回nil表示该行不能被选中；另外也可返回重定向的indexPath，使选择某行时会跳到另一行
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath;
}

//某行已经被选中时调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//在弹出警告后自动取消选中表视图单元
    
    if (tableView == realRankingTableView) {
        //进入优惠券详情 -- 估计需要再添加一个判断语句用来不请求列表操作
    }
    else{
        //进入团购详情 -- 估计需要再添加一个判断语句用来不请求列表操作
    }
    
}
//设置每行缩进级别
- (NSInteger) tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

//设置行高度
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark -
#pragma mark 左右滑动相关函数

- (void)initScrollView {
    
    //设置 tableScrollView
    // a page is the width of the scroll view
    nibScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, 320, 430)];
    nibScrollView.pagingEnabled = YES;
    nibScrollView.clipsToBounds = NO;
    nibScrollView.contentSize = CGSizeMake(nibScrollView.frame.size.width * 3, nibScrollView.frame.size.height);
    nibScrollView.showsHorizontalScrollIndicator = NO;
    nibScrollView.showsVerticalScrollIndicator = NO;
    nibScrollView.scrollsToTop = NO;
    nibScrollView.delegate = self;
    
    [nibScrollView setContentOffset:CGPointMake(0, 0)];
    
    //公用
    currentPage = 0;
    pageControl.numberOfPages = 2;
    pageControl.currentPage = 0;
    pageControl.backgroundColor = [UIColor whiteColor];
    [self createAllEmptyPagesForScrollView];
}

- (void)createAllEmptyPagesForScrollView {
    
    //设置 tableScrollView 内部数据
    realRankingTableView = [[UITableView alloc]init ];
    realRankingTableView.frame = CGRectMake(320*0, 0, 320, nibScrollView.frame.size.height);
    senvenHisRankingTableView = [[UITableView alloc]init ];
    senvenHisRankingTableView.frame = CGRectMake(320*1, 0, 320, nibScrollView.frame.size.height);
    allRankingTableView = [[UITableView alloc]init ];
    allRankingTableView.frame = CGRectMake(320*2, 0, 320, nibScrollView.frame.size.height);
    
    //设置tableView委托并添加进视图
    realRankingTableView.delegate = self;
    realRankingTableView.dataSource = self;
    [nibScrollView addSubview: realRankingTableView];
    senvenHisRankingTableView.delegate = self;
    senvenHisRankingTableView.dataSource = self;
    [nibScrollView addSubview: senvenHisRankingTableView];
    allRankingTableView.delegate = self;
    allRankingTableView.dataSource = self;
    [nibScrollView addSubview: allRankingTableView];
    
    //设置 nibTableView 数据源数组 -- 仅仅用与测试
    couponArry = [[NSArray alloc]initWithObjects:@"coupon1",@"coupon2",@"coupon3", @"coupon4",nil ];
    groupbuyArry = [[NSArray alloc]initWithObjects:@"groupbuy1",@"groupbuy2",@"groupbuy3", nil ];
    
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = self.nibScrollView.frame.size.width;
    int page = floor((self.nibScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    pageControl.currentPage = page;
    currentPage = page;
    pageControlUsed = NO;
    [self btnActionShow];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //暂不处理 - 其实左右滑动还有包含开始等等操作，这里不做介绍
    [self getData];
}

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
    return YES;
}
- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    return NO;
}

#pragma 网络数据代理
-(void)GamePlayerAPIClient:(GamePlayerAPIClient *)client didFailWithError:(NSError *)error
{
    
}

-(void)GamePlayerAPIClient:(GamePlayerAPIClient *)client didUpdateWithData:(id)result
{
    NSLog(@"result:::::::::%@::::::::::::::",result);
}

-(void)getData
{
    [GamePlayerAPIClient sharedClient].delegate=self;
    [[GamePlayerAPIClient sharedClient] getData:@"/rankings" withParameter:nil];
}

@end
