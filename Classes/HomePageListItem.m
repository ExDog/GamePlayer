#import "HomePageListItem.h"

@implementation HomePageListItem

//- (id)initWithFrame:(CGRect)frame image:(UIImage *)image text:(NSString *)imageTitle
- (instancetype)initWithAttributes:(NSDictionary *)attributes 
{
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        [self setUserInteractionEnabled:YES];
        
        //self.imageTitle = imageTitle;
        //self.image = image;
        self.imageTitle=[attributes objectForKey:@""];
        //调用苹果api直接获取图片
      //  self.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[attributes objectForKey:@""]]]];
        self.image= [[NSURL URLWithString:@"http://i.imgur.com/r4uwx.jpg"] placeholderImage:[UIImage imageNamed:@"charts_test5"]];
     //   imageView setImageWithURL
        // Background view
       UIImageView *backgroundView= [[[UIView alloc] initWithFrame:CGRectNull] autorelease];
    
   //     backgroundView.backgroundColor =[UIColor colorWithPatternImage:self.image];
     //   backgroundView.tag=55555;
        
        imageRect = CGRectMake(0.0, 0.0, 80.0, 130.0);
        [backgroundView setFrame:imageRect];
        [self addSubview:backgroundView];
        
        // Label
        UIView *textLabelBackgroundView = [[[UIView alloc] initWithFrame:CGRectNull] autorelease];
        textLabelBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
                textRect = CGRectMake(0.0, imageRect.origin.y + imageRect.size.height - 20.0, 80.0, 20.0);
        
               [textLabelBackgroundView setFrame:textRect];
        UILabel *textLabel = [[[UILabel alloc] initWithFrame:CGRectNull] autorelease];
        textLabel.textAlignment = UITextAlignmentCenter;
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.font = [UIFont systemFontOfSize:12];
        
        [textLabel setFrame:CGRectMake(0, 0, 80, 20)];
        [textLabel setText:self.imageTitle];
        [textLabelBackgroundView addSubview:textLabel];
        [self addSubview:textLabelBackgroundView];
    }
    
    return self;
}

@end
