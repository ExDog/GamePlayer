#import "GamePlayerAPIClient.h"


@implementation GamePlayerAPIClient
   
+ (instancetype)sharedClient {
    static GamePlayerAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:SERVER]];
    });
    
    return _sharedClient;
}

/**
 * 一个最基础的url
 */
- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
     self.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
    return self;
}

-(void)getData:(NSString*)url withParameter:(NSDictionary*)parameters{
   NSLog(@"Url%@====",url);
    [self POST:url parameters: parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@=====",responseObject);
        id result=[self dealJsonDataWithUrlString:url withJson:responseObject];
        if([self.delegate respondsToSelector:@selector(GamePlayerAPIClient:didUpdateWithData:)])
            [self.delegate GamePlayerAPIClient:self didUpdateWithData:result];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@===",error);
        if ([self.delegate respondsToSelector:@selector(GamePlayerAPIClient:didFailWithError:)]) {
            [self.delegate GamePlayerAPIClient:self didFailWithError:error];
        }
    }];
    
    /**
     *  返回当前的网络状态
     */
    NSLog(@"net type=%d",[[self reachabilityManager] networkReachabilityStatus]);
}

/**
 * 处理数据
 */
-(id)dealJsonDataWithUrlString:(NSString*) url withJson:(NSDictionary*)json
{
    if ([json objectForKey:@"success"])
        return [json objectForKey:@"result"];
    else
        return nil;
}

#pragma 以下代码没用，用于测试
/**
 *  网络连接部分，返回json数据的字典
 */
-(void)getDataWithJsonAt:(NSString*)urlString AndParams:(NSDictionary*)params
{
    NSLog(@"请求数据 %@::::::::::%@",urlString,params);
    NSURL *url = [NSURL URLWithString:[SERVER stringByAppendingString:urlString]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:10.f];
    [request setHTTPMethod:@"POST"];
    
    AFHTTPRequestOperation *oper=[[AFHTTPRequestOperation alloc]initWithRequest:request];
    [oper setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData: responseObject options:NSJSONReadingMutableLeaves error:nil];
         [self dealJsonDataWithUrlString:urlString withJson:weatherDic];
         NSLog(@"成功呢！json 2222===%@",weatherDic);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Failure: %@", error);
     }];
    [oper start];
}



/**
 *    事例程序
 *   向服务器发送post请求返回gson数据队
 *
 */
/*
 -(void)getDataWithJsonAt:(NSString*)urlString AndParams:(NSDictionary*)params AddItem:(HomePageListItem *)item
 {
 NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:3000"];
 AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
 NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"http://127.0.0.1:3000" parameters:params];
 request.timeoutInterval=10.0;
 AFHTTPRequestOperation
 AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
 NSLog(@"==%@===",JSON);
 NSDictionary*dic=JSON;
 //      NSDictionary*dic2=[dic objectForKey:@"result"];
 NSArray* dic3= [dic objectForKey:@"result"];
 NSDictionary *dic4 =[dic3 objectAtIndex:0];
 NSString *imageUrl=[dic4 objectForKey:@"pageImageUrl"];
 NSLog(@"===%@:::",imageUrl);
 [self setImage:imageUrl AddItem:item];
 }
 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
 NSLog(@"==%@::::::::::false:%@",JSON,error);
 }];
 [operation start];
 }
 */


/* 异步加载图片
-(void)setImage:(NSString *) imagePath AddItem:(HomePageListItem *)item
{
    UIImage*image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imagePath]]];
    
     UIImageView* imageView=[[UIImageView alloc] initWithFrame:self.view.frame];
     imageView.image=image;
     [self.view addSubview:imageView];
     
    // item.image=image;
    UIView* bgView=[item viewWithTag:55555];
    bgView.backgroundColor=[UIColor colorWithPatternImage:image];
    item.image=image;
}
*/
@end
