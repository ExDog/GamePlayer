

#import "GamePlayerTabBarController.h"
#import "GamePlayerTabBar.h"
#import "GamePlayerAppDelegate.h"
#import "ChannelViewController.h"
#import "GamePlayerTabBarController.h"
#import "HomePageViewController.h"
#import "QBSimpleSyncRefreshControl.h"
#import "TopSearchBarTableViewController.h"
#define kTabBarHeight 40.0f

static GamePlayerTabBarController *leveyTabBarController;

@implementation UIViewController (LeveyTabBarControllerSupport)

- (GamePlayerTabBarController *)leveyTabBarController
{
	return leveyTabBarController;
}

@end

@interface GamePlayerTabBarController (private)
- (void)displayViewAtIndex:(NSUInteger)index;

@end

@implementation GamePlayerTabBarController
@synthesize delegate = _delegate;
@synthesize selectedViewController = _selectedViewController;
@synthesize viewControllers = _viewControllers;
@synthesize selectedIndex = _selectedIndex;
@synthesize tabBarHidden = _tabBarHidden;
@synthesize animateDriect;

#pragma mark -
#pragma mark lifecycle
- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr
{
	self = [super init];
	if (self != nil)
	{
		_viewControllers = [[NSMutableArray arrayWithArray:vcs] retain];
		
		_containerView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
		
		_transitionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, _containerView.frame.size.height - kTabBarHeight)];
		_transitionView.backgroundColor =  [UIColor groupTableViewBackgroundColor];
		
		_tabBar = [[GamePlayerTabBar alloc] initWithFrame:CGRectMake(0, _containerView.frame.size.height - kTabBarHeight, 320.0f, kTabBarHeight) buttonImages:arr];
		_tabBar.delegate = self;
        leveyTabBarController = self;
        animateDriect = 0;
	}
	return self;
}

- (void)loadView 
{
	[super loadView];
    
    /**
     *右边搜索按钮
     */

UIBarButtonItem *bar1=[self setRightNavigation: [UIImage imageNamed:@"favourate_my_zhanghao.png"] size:CGRectMake(270, 0, 30, 30)];
UIBarButtonItem *bar2=[self setRightNavigation: [UIImage imageNamed:@"favourate_play_record.png"] size:CGRectMake(270, 0, 30, 30)];
    self.navigationItem.rightBarButtonItems=[[NSArray alloc]initWithObjects:bar1,bar2, nil];
//    [playNowButton release];
//    //设置导航栏高度
//    UINavigationBar *bar1 = [self.navigationController navigationBar];
//    CGFloat navBarHeight = 20.0f;
//    CGRect frame = CGRectMake(0.0f, 0.0f, 320.0f, navBarHeight);
////    [bar1 setFrame:frame];
//    [bar1 setBounds:frame];
    [self setNavBar];
    [self setLeftNavigation: [UIImage imageNamed:@"gameplayer_title.png"] size:CGRectMake(0, 0, 60, 30)];
	[_containerView addSubview:_transitionView];
	[_containerView addSubview:_tabBar];
	self.view = _containerView;
}

- (void) setNavBar
{
    //    self.navigationController.navigationBarHidden = NO;//显示nav，这里使用动画
    [self.navigationController  setNavigationBarHidden:NO animated:YES];
    
    //设置Navigation Bar颜色
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(30/255.0) green:(175/255.0) blue:(200/255.0) alpha:1];
    
    self.title = @"e信视频";
    
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

-(void)setLeftNavigation:(UIImage*) bk size:(CGRect) size
{
    UIButton *playNowButton = [[UIButton alloc] initWithFrame:size];
    [playNowButton setBackgroundImage:bk forState:UIControlStateNormal];
//    [playNowButton addTarget:self action:@selector(hide)forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *bar =[[UIBarButtonItem alloc] initWithCustomView:playNowButton];
    self.navigationItem.leftBarButtonItem = bar;
    
    [playNowButton release];
}

-(UIBarButtonItem *)setRightNavigation:(UIImage*) bk size:(CGRect) size
{
    UIButton *playNowButton = [[UIButton alloc] initWithFrame:size];
    [playNowButton setBackgroundImage:bk forState:UIControlStateNormal];
     [playNowButton addTarget:self action:@selector(hide)forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *bar =[[UIBarButtonItem alloc] initWithCustomView:playNowButton];
//    self.navigationItem.rightBarButtonItem = bar;
    [playNowButton release];
    return bar;
}
- (void)viewDidLoad 
{
    [super viewDidLoad];
    self.selectedIndex = 0;
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	
	_tabBar = nil;
	_viewControllers = nil;
}

- (void)dealloc 
{
    _tabBar.delegate = nil;
	[_tabBar release];
    [_containerView release];
    [_transitionView release];
	[_viewControllers release];
    [super dealloc];
}

#pragma mark - instant methods

- (GamePlayerTabBar *)tabBar
{
	return _tabBar;
}

- (BOOL)tabBarTransparent
{
	return _tabBarTransparent;
}

- (void)setTabBarTransparent:(BOOL)yesOrNo
{
	if (yesOrNo == YES)
	{
		_transitionView.frame = _containerView.bounds;
	}
	else
	{
		_transitionView.frame = CGRectMake(0, 0, 320.0f, _containerView.frame.size.height - kTabBarHeight);
	}
}




- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated
{
	if (yesOrNO == YES)
	{
		if (self.tabBar.frame.origin.y == self.view.frame.size.height)
		{
			return;
		}
	}
	else 
	{
		if (self.tabBar.frame.origin.y == self.view.frame.size.height - kTabBarHeight)
		{
			return;
		}
	}
	
	if (animated == YES)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3f];
		if (yesOrNO == YES)
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		else 
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		[UIView commitAnimations];
	}
	else 
	{
		if (yesOrNO == YES)
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		else 
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
	}
}


//- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated
//{
//    [self hidesTabBar:yesOrNO animated:animated driect:animateDriect];
//}
//
//- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated driect:(NSInteger)driect
//{
//    // driect: 0 -- 上下  1 -- 左右
//    
//    NSInteger kTabBarWidth = [[UIScreen mainScreen] applicationFrame].size.width;
//    
//	if (yesOrNO == YES)
//	{
//        if (driect == 0)
//        {
//            if (self.tabBar.frame.origin.y == self.view.frame.size.height)
//            {
//                return;
//            }
//        }
//        else
//        {
//            if (self.tabBar.frame.origin.x == 0 - kTabBarWidth)
//            {
//                return;
//            }
//        }
//	}
//	else 
//	{
//        if (driect == 0)
//        {
//            if (self.tabBar.frame.origin.y == self.view.frame.size.height - kTabBarHeight)
//            {
//                return;
//            }
//        }
//        else
//        {
//            if (self.tabBar.frame.origin.x == 0)
//            {
//                return;
//            }
//        }
//	}
//	
//	if (animated == YES)
//	{
//		[UIView beginAnimations:nil context:NULL];
//		[UIView setAnimationDuration:0.3f];
//		if (yesOrNO == YES)
//		{
//            if (driect == 0)
//            {
//                self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
//            }
//            else
//            {
//                self.tabBar.frame = CGRectMake(0 - kTabBarWidth, self.tabBar.frame.origin.y, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
//            }
//		}
//		else 
//		{
//            if (driect == 0)
//            {
//                self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
//            }
//            else
//            {
//                self.tabBar.frame = CGRectMake(0, self.tabBar.frame.origin.y, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
//            }
//		}
//		[UIView commitAnimations];
//	}
//	else 
//	{
//		if (yesOrNO == YES)
//		{
//            if (driect == 0)
//            {
//                self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
//            }
//            else
//            {
//                self.tabBar.frame = CGRectMake(0 - kTabBarWidth, self.tabBar.frame.origin.y, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
//            }
//		}
//		else 
//		{
//            if (driect == 0)
//            {
//                self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
//            }
//            else
//            {
//                self.tabBar.frame = CGRectMake(0, self.tabBar.frame.origin.y, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
//            }
//		}
//	}
//}
//
- (NSUInteger)selectedIndex
{
	return _selectedIndex;
}
- (UIViewController *)selectedViewController
{
    return [_viewControllers objectAtIndex:_selectedIndex];
}

-(void)setSelectedIndex:(NSUInteger)index
{
    [self displayViewAtIndex:index];
    [_tabBar selectTabAtIndex:index];
}

- (void)removeViewControllerAtIndex:(NSUInteger)index
{
    if (index >= [_viewControllers count])
    {
        return;
    }
    // Remove view from superview.
    [[(UIViewController *)[_viewControllers objectAtIndex:index] view] removeFromSuperview];
    // Remove viewcontroller in array.
    [_viewControllers removeObjectAtIndex:index];
    // Remove tab from tabbar.
    [_tabBar removeTabAtIndex:index];
}

- (void)insertViewController:(UIViewController *)vc withImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    [_viewControllers insertObject:vc atIndex:index];
    [_tabBar insertTabWithImageDic:dict atIndex:index];
}


#pragma mark - Private methods
- (void)displayViewAtIndex:(NSUInteger)index
{
    // Before change index, ask the delegate should change the index.
    if ([_delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) 
    {
        if (![_delegate tabBarController:self shouldSelectViewController:[self.viewControllers objectAtIndex:index]])
        {
            return;
        }
    }
    // If target index if equal to current index, do nothing.
    if (_selectedIndex == index && [[_transitionView subviews] count] != 0) 
    {
        return;
    }
    NSLog(@"Display View.");
    _selectedIndex = index;
    
	UIViewController *selectedVC = [self.viewControllers objectAtIndex:index];
	
	selectedVC.view.frame = _transitionView.frame;
	if ([selectedVC.view isDescendantOfView:_transitionView]) 
	{
		[_transitionView bringSubviewToFront:selectedVC.view];
	}
	else
	{
		[_transitionView addSubview:selectedVC.view];
	}
    
    // Notify the delegate, the viewcontroller has been changed.
    if ([_delegate respondsToSelector:@selector(tabBarController:didSelectViewController::)]) 
    {
        [_delegate tabBarController:self didSelectViewController:selectedVC];
    }

}

#pragma mark -
#pragma mark tabBar delegates
- (void)tabBar:(GamePlayerTabBar *)tabBar didSelectIndex:(NSInteger)index
{
	if (self.selectedIndex == index) {
        UINavigationController *nav = [self.viewControllers objectAtIndex:index];
        [nav popToRootViewControllerAnimated:YES];
    }else {
        [self displayViewAtIndex:index];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
}


- (void)hide
{
    static NSInteger dir = 0;
    
    TopSearchBarTableViewController *firstVC = [[TopSearchBarTableViewController alloc] init];
    
    //firstVC.hidesBottomBarWhenPushed = YES;
    GamePlayerAppDelegate* appDelegate = (GamePlayerAppDelegate*)[UIApplication sharedApplication].delegate;
    
    dir++;
    appDelegate.leveyTabBarController.animateDriect = dir % 2;
    firstVC.hidesBottomBarWhenPushed = YES;
    //[appDelegate.leveyTabBarController hidesTabBar:YES animated:YES];
    [self.navigationController pushViewController:firstVC animated:YES];
    [firstVC release];
}





@end
