//
//  GamePlayerAPIClient.h
//  GamePlayer
//
//  Created by talent_xia on 13-11-23.
//
//

#import "AFNetworking.h"
#import "EXConstants.h"
@protocol HttpClientDelegate;
@interface GamePlayerAPIClient :  AFHTTPRequestOperationManager
+ (instancetype)sharedClient;
@property(weak) id<HttpClientDelegate> delegate;
-(void)getData:(NSString*)url withParameter:(NSDictionary*)parameters;
@end

@protocol HttpClientDelegate <NSObject>
-(void)GamePlayerAPIClient:(GamePlayerAPIClient *)client didUpdateWithData:(id)result;
-(void)GamePlayerAPIClient:(GamePlayerAPIClient *)client didFailWithError:(NSError *)error;
@end