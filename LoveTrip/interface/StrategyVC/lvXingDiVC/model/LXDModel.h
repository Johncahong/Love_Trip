//
//  LXDModel.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/8.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXDModel : NSObject

//"id": 35443,
//"name": "京都清水寺",
//"attraction_trips_count": 785,
//"user_score": "4.33",
//"description": "清水寺依山势而建的、靠数百根巨大的圆木撑起的大殿露台“清水舞台”。",
//"name_en": "Kiyomizu Temple",
//"attraction_type": null,
//"description_summary": "清水寺依山势而建的、靠数百根巨大的圆木撑起的大殿露台“清水舞台”。",
//"image_url": "http://m.chanyouji.cn/attractions/35443.jpg"
@property(nonatomic,copy)NSString *idStr;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *attraction_trips_count;
@property(nonatomic,copy)NSString *descriptionStr;
@property(nonatomic,copy)NSString *user_score;
@property(nonatomic,copy)NSString *description_summary;
@property(nonatomic,copy)NSString *image_url;

@end
