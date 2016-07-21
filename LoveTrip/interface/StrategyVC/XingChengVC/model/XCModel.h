//
//  XCModel.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/8.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCModel : NSObject

//"id": 1693,
//"name": "日本全景7日游",
//"budget": 0,
//"start_date": null,
//"description": "京都的优雅，东京大阪的时尚，富士山的秀美，北海道的浪漫一次体验，7天最全面的日本游线路。",
//"plan_days_count": 7,
//"plan_nodes_count": 38,
//"user_name": "",
//"image_url": "http://m.chanyouji.cn/plans/1693.jpg",
//"updated_at": 1410504676
@property(nonatomic,copy)NSString *IDStr;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *descriptionStr;
@property(nonatomic,copy)NSString *plan_days_count;
@property(nonatomic,copy)NSString *plan_nodes_count;
@property(nonatomic,copy)NSString *image_url;

@end
