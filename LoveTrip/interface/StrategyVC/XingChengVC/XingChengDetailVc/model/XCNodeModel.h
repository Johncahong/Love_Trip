//
//  XCNodeModel.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/8.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCNodeModel : NSObject
//"id": 174511,
//"entry_id": 156560,
//"position": 0,
//"candidate": false,
//"tips": "#国内到大阪# 从国内前往大阪的航班都降落在关西国际机场，从机场前往大阪市区可搭乘：南海电铁空港急行往返难波站（890日元、约42分钟）或关空机场巴士往返难波站（1,000日元、50分）等多种方式。",
//"lat": "34.43489",
//"lng": "135.244451",
//"distance": 0,
//"image_url": "http://m.chanyouji.cn/attractions/156560.jpg",
//"entry_name": "关西国际机场",
//"entry_type": "Attraction",
//"attraction_type": "transport",
//"user_entry": false,
//"destination": {
//    "id": 167,
//    "name_zh_cn": "关西"
@property(nonatomic,copy)NSString *idStr;
@property(nonatomic,copy)NSString *entry_id;
@property(nonatomic,copy)NSString *position;
@property(nonatomic,copy)NSString *tips;
@property(nonatomic,copy)NSString *entry_name;
@property(nonatomic,copy)NSString *image_url;
@property(nonatomic,copy)NSString *memo;

@end
