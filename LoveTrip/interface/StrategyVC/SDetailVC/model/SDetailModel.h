//
//  SDetailModel.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/8.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDetailModel : NSObject
//"id": 55,
//"name_zh_cn": "日本",
//"name_en": "Japan",
//"poi_count": 1010,
//"plans_count": 6,
//"articles_count": 6,
//"contents_count": 2438,
//"destination_trips_count": 3740,
//"locked": false,
//"wiki_app_publish": true,
//"updated_at": 1457039212,
//"image_url": "http://m.chanyouji.cn/destinations/55-landscape.jpg",
//"guides_count": 7,

@property(nonatomic,copy)NSString *idStr;
@property(nonatomic,copy)NSString *name_zh_cn;
@property(nonatomic,copy)NSString *name_en;
@property(nonatomic,copy)NSString *image_url;
@end
