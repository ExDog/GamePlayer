//
//  User.h
//  GamePlayer
//
//  Created by talent_xia on 13-11-23.
//
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, assign) NSUInteger userID;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, unsafe_unretained) NSURL *avatarImageURL;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
