//
//  User.m
//  GamePlayer
//
//  Created by talent_xia on 13-11-23.
//
//

#import "User.h"

@implementation User

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.userID = [[attributes valueForKeyPath:@"id"] integerValue];
    self.username = [attributes valueForKeyPath:@"username"];
//    self.avatarImageURLString = [attributes valueForKeyPath:@"avatar_image.url"];
    
    return self;
}
@end
