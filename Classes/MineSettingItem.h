//
//  MineSettingItem.h
//  GamePlayer
//
//  Created by talent_xia on 13-9-29.
//
//

#import <UIKit/UIKit.h>

@interface MineSettingItem : UIView
{
CGRect textRect;
CGRect imageRect;
}
@property (nonatomic, retain) NSObject *objectTag;

@property (nonatomic, retain) NSString *imageContent;
@property (nonatomic, retain) UIImage *image;

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image text:(NSString *)imageTitle;
@end
