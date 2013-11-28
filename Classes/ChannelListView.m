//
//  ChannelListView.m
//  GamePlayer
//
//  Created by talent_xia on 13-9-26.
//
//

#import "ChannelListView.h"

@implementation ChannelListView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title items:(NSMutableArray *)items
{
    self = [super initWithFrame:frame];
    
    if (self) {
        int i=0;
        for(UIView *item in items) {
            [item setFrame:CGRectMake( 80*i++, 0, 80, 80)];
            
            UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTapped:)];
            [item addGestureRecognizer:singleFingerTap];
            
            [self addSubview:item];
        }
    }
    
    return self;
}

- (void)itemTapped:(UITapGestureRecognizer *)recognizer {
    UIImageView *item = (UIImageView *)recognizer.view;
    NSLog(@"channelListViewSelect");
    if (item != nil) {
        //        [self.delegate didSelectItem:item];
    }
}
@end
