//
//  VideoInfo.h
//  GamePlayer
//
//  Created by 夏国强 on 13-9-25.
//
//

#import <UIKit/UIKit.h>

@interface VideoInfo : NSObject
{
    NSString *vdo_id;
    NSString *vdo_name;
    NSString *vdo_info;//视频简介
    NSString *vdo_reso;//视频分辨率
    NSString *vdo_src;//视频来源
    NSString *vdo_anno;//视频解说人
    NSString *vdo_length;//视频长度
    NSString *vdo_tag;//视频标签
    NSString *vdo_provider;//视频提供者
    NSString *vdo_up_time;//视频上传时间
    NSString *vdo_pic_num;//视频截图
    NSString *vdo_game_no;//游戏归属类
    NSString *vdo_game_type;//游戏类型
    NSString *vdo_grade;//好评等级
}
@property(nonatomic,strong) NSString *vdo_id;
@property(nonatomic,strong) NSString *vdo_name;
@property(nonatomic,strong) NSString *vdo_info;
@property(nonatomic,strong) NSString *vdo_reso;
@property(nonatomic,strong) NSString *vdo_src;
@property(nonatomic,strong) NSString *vdo_anno;
@property(nonatomic,strong) NSString *vdo_length;
@property(nonatomic,strong) NSString *vdo_tag;
@property(nonatomic,strong) NSString *vdo_provider;
@property(nonatomic,strong) NSString *vdo_up_time;
@property(nonatomic,strong) NSString *vdo_pic_num;
@property(nonatomic,strong) NSString *vdo_game_no;
@property(nonatomic,strong) NSString *vdo_game_type;
@property(nonatomic,strong) NSString *vdo_grade;
@end
