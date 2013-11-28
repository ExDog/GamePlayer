//
//  UserGuideViewController.m
//  GamePlayer
//
//  Created by 夏国强 on 13-9-23.
//
//

#import "UserGuideViewController.h"
#import "GamePlayerAppDelegate.h"

@implementation UserGuideViewController
 - (void)viewDidLoad
{
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        self.view.backgroundColor = [UIColor blackColor];
   
        [self initGuide];   //加载新用户指导页面
    }

 - (void)initGuide
 {
         UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
         [scrollView setContentSize:CGSizeMake(1280, 0)];
         [scrollView setPagingEnabled:YES];  //视图整页显示
         //    [scrollView setBounces:NO]; //避免弹跳效果,避免把根视图露出来
    
         UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
         [imageview setImage:[UIImage imageNamed:@"charts_test5.png"]];
         [scrollView addSubview:imageview];
         [imageview release];
    
         UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(320, 0, 320, 460)];
         [imageview1 setImage:[UIImage imageNamed:@"charts_test3.jpg"]];
         [scrollView addSubview:imageview1];
         [imageview1 release];
    
         UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(640, 0, 320, 460)];
         [imageview2 setImage:[UIImage imageNamed:@"charts_test1.jpg"]];
         [scrollView addSubview:imageview2];
         [imageview2 release];
    
         UIImageView *imageview3 = [[UIImageView alloc] initWithFrame:CGRectMake(960, 0, 320, 460)];
         [imageview3 setImage:[UIImage imageNamed:@"charts_test2.jpg"]];
         imageview3.userInteractionEnabled = YES;    //打开imageview3的用户交互;否则下面的button无法响应
         [scrollView addSubview:imageview3];
         [imageview3 release];
    
         UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//在imageview3上加载一个透明的button
         [button setTitle:nil forState:UIControlStateNormal];
         [button setBackgroundColor:[UIColor blackColor]];
         [button setFrame:CGRectMake(46, 371, 230, 37)];
         [button addTarget:self action:@selector(firstpressed) forControlEvents:UIControlEventTouchUpInside];
         [imageview3 addSubview:button];
    
         [self.view addSubview:scrollView];
         [scrollView release];
     }

- (void) firstpressed
{
      GamePlayerAppDelegate* appDelegate = (GamePlayerAppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate start];
  //  [[GamePlayerAppDelegate sharedAppDelegate] start];
}
@end
