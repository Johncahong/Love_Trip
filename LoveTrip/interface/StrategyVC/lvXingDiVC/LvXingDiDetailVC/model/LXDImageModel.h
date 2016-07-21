//
//  LXDImageModel.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/9.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXDImageModel : NSObject



//"id": 3684607,
//              "description": "",
//              "width": 1600,
//              "height": 900,
//              "photo_url": "http://p.chanyouji.cn/93844/1388465098531p18d3et14i1gg7o6a3u8t3r10el1t.jpg",

@property(nonatomic,copy)NSString *idStr;
@property(nonatomic,copy)NSString *descriptionStr;
@property(nonatomic,copy)NSString *width;
@property(nonatomic,copy)NSString *height;
@property(nonatomic,copy)NSString *photo_url;
@end
