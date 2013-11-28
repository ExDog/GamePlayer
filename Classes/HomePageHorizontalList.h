
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "HomePageListItem.h"
//#import "POHorizontalListDelegate.h"

#define DISTANCE_BETWEEN_ITEMS  15.0
#define LEFT_PADDING            5.0
#define ITEM_WIDTH              72.0
#define TITLE_HEIGHT           5.0

/**
 *  每个item代理触发事件
 */
@protocol HomePageHorizontalListDelegate
- (void) didSelectItem:(HomePageListItem *)item;
@end

@interface HomePageHorizontalList : UIView <UIScrollViewDelegate> {
    CGFloat scale;
}

@property (nonatomic, retain) UIScrollView *scrollView;

@property (nonatomic, assign) id<HomePageHorizontalListDelegate> delegate;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title items:(NSMutableArray *)items;

@end
