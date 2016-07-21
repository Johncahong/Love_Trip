//
//  XCDetailModel.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/8.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCDetailModel : NSObject

//"id": 1628,
//"name": "日本关西+关东经典7日游",
//"description": "从大阪进，东京出，7天全方位游览关西和关东各大城市和著名景点，如大阪城公园、奈良公园、京都清水寺、东京塔和箱根温泉等。",
//"budget": 0,
//"budget_description": "",
//"tips": "",
//"start_date": null,
//"current_user_favorite": false,
//"updated_at": 1398310109,
//"image_url": "http://m.chanyouji.cn/plans/1628.jpg",
@property(nonatomic,copy)NSString *IDStr;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *image_url;
@property(nonatomic,strong)NSMutableArray *plan_days;
@end
