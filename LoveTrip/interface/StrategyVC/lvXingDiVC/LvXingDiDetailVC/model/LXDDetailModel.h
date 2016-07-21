//
//  LXDDetailModel.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/9.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXDDetailModel : NSObject
//{
//    "id": 35443,
//    "name_zh_cn": "京都清水寺",
//    "name_en": "Kiyomizu Temple",
//    "description": "清水寺依山势而建的、靠数百根巨大的圆木撑起的大殿露台“清水舞台”。",
//    "tips_html": "<strong>#官方网站#</strong>\n<p><a href=\"http://www.kiyomizudera.or.jp/\">http://www.kiyomizudera.or.jp/</a></p>\n<strong>#交通信息#</strong>\n<p>清水寺位于祗园东南侧的山坡上，从八坂神社马路对面的祗园站搭乘202路、206路、207路2站至清水道站，再步行约10分钟即至。<br>\n从京都站前搭乘市营206路8站至清水道站，再步行约10分钟即至。</p>\n<strong>#门票信息#</strong>\n<p>成人一般参拜 300日元 学生 200日元<br>\n夜间特别参拜 400日元 学生 200日元（季节性开放，具体参照官网）</p>\n<strong>#开放时间#</strong>\n<p>早晨6:00～下午6:00（随季节会有不同，具体参照官网）<br>\n赏樱/枫季会在营业时间结束后的晚上7点左右再次开放。</p>\n<strong>#游玩指南#</strong>\n<p>清水寺内的景观很多，除了大殿之外还有著名的音羽瀑布、和神庙、治修神社等。每年11月，寺庙会在夜间开放供游人观赏夜枫。</p>\n<strong>#建议游玩时间#</strong>\n<p>1～2小时。</p>\n",
//    "user_score": "4.33",
//    "photos_count": 8077,
//    "attraction_trips_count": 787,
//    "lat": "34.994835",
//    "lng": "135.784953",
//    "attraction_type": null,
//    "address": "日本京都东山区清水1丁目294",
//    "ctrip_id": 78812,
//    "updated_at": 1406091715,
//    "image_url": "http://m.chanyouji.cn/attractions/35443.jpg",
//    "attractions_count": 713,
//    "activities_count": 10,
//    "restaurants_count": 20,
//    "attraction_trip_tags": [


@property(nonatomic,copy)NSString *idStr;
@property(nonatomic,copy)NSString *descriptionStr;
@property(nonatomic,copy)NSString *photos_count;
@property(nonatomic,copy)NSString *attraction_trips_count;
@property(nonatomic,copy)NSString *lat;
@property(nonatomic,copy)NSString *lng;
@property(nonatomic,copy)NSString *image_url;
@property(nonatomic,copy)NSString *name_zh_cn;
@property(nonatomic,copy)NSString *name_en;
@property(nonatomic,strong)NSMutableArray *attraction_trip_tags;
@end
