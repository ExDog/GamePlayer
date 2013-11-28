//
//  MineSettingViewController.m
//  GamePlayer
//
//  Created by 夏国强 on 13-7-29.
//
//

#import "MineSettingViewController.h"
#import "MineSettingItem.h"
@implementation MineSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    mineSettingTab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    [mineSettingTab setDataSource:self];
    [mineSettingTab setDelegate:self];
    [self.view addSubview:mineSettingTab];
}
- (void)dealloc {
   
    [super dealloc];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
#pragma mark - TableView Delegate and DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    return tableView.rowHeight + [PrettyTableViewCell tableView:tableView neededHeightForIndexPath:indexPath];
    return  70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier: CellIdentifier] autorelease];
    }else{
        //cell中本来就有一个subview，如果是重用cell，则把cell中自己添加的subview清除掉，避免出现重叠问题
        //         [[cell.subviews objectAtIndex:1] removeFromSuperview];
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
    }

   [cell.contentView addSubview:[[MineSettingItem alloc]initWithFrame:CGRectMake(0, 0, 320, 100) image:[UIImage imageNamed:@"searchbutton"] text:@"我的设置"] ];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}
@end
