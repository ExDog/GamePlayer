//
//  MineSettingItem.m
//  GamePlayer
//
//  Created by talent_xia on 13-9-29.
//
//

#import "MineSettingItem.h"

@implementation MineSettingItem
- (id)initWithFrame:(CGRect)frame image:(UIImage *)image text:(NSString *)imageTitle
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUserInteractionEnabled:YES];
        
        self.imageContent = imageTitle;
        self.image = image;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        CALayer *roundCorner = [imageView layer];
        [roundCorner setMasksToBounds:YES];
        [roundCorner setCornerRadius:8.0];
        [roundCorner setBorderColor:[UIColor blackColor].CGColor];
        [roundCorner setBorderWidth:1.0];
        
        UILabel *title = [[UILabel alloc] init];
        [title setBackgroundColor:[UIColor clearColor]];
        [title setFont:[UIFont boldSystemFontOfSize:18.0]];
        [title setOpaque: NO];
        [title setText:imageTitle];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        imageRect = CGRectMake(20.0, 5.0, 50.0, 50.0);
        textRect = CGRectMake(150.0, 10.0, 200, 52.0);
        
        [title setFrame:textRect];
        [imageView setFrame:imageRect];
        
        [self addSubview:title];
        [self addSubview:imageView];
    }
    
    return self;
}

@end
