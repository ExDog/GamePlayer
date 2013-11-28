//  FNMyCollectionViewController.h
//  TabBarController_LYS
//
//  Created by lys on 12-8-23.
//  Copyright (c) 2012年 lys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GamePlayerAPIClient.h"
@interface RankingCollectionViewController : UIViewController< UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate,HttpClientDelegate>
{
    //数据部分
    NSArray *couponArry;
    NSArray *groupbuyArry;
    
    //页面展示部分
    UITableView *realRankingTableView;
    UITableView *senvenHisRankingTableView;
    UITableView *allRankingTableView;
    
    //左右滑动部分
	UIPageControl *pageControl;
    int currentPage;
    BOOL pageControlUsed;
}

@property (retain, nonatomic)  UIButton *realRankingButton;
@property (retain, nonatomic)  UIButton *sevenPassRankingButton;
@property(retain,nonatomic)   UIButton *allRankingButton;
@property (retain, nonatomic)  UILabel *slidLabel;//用于指示作用
@property (retain, nonatomic)  UIScrollView *nibScrollView;

@end
