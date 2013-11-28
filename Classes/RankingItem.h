//
//  RankingItem.h
//  GamePlayer
//
//  Created by 夏国强 on 13-7-28.
//
//

#import <UIKit/UIKit.h>

@interface RankingItem : UIView
{
    CGRect textRect;
    CGRect imageRect;
}
@property (nonatomic, retain) NSObject *objectTag;

@property (nonatomic, retain) NSString *imageContent;
@property (nonatomic, retain) UIImage *image;

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image text:(NSString *)imageTitle;

@end
