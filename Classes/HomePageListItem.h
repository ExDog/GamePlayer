

#import <UIKit/UIKit.h>


@interface HomePageListItem : UIView {
    CGRect textRect;
    CGRect imageRect;
}

@property (nonatomic, retain) NSObject *objectTag;

@property (nonatomic, retain) NSString *imageTitle;
@property (nonatomic, retain) UIImage *image;

- (instancetype)initWithAttributes:(NSDictionary *)attributes ;

@end
