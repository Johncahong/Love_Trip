//
//  SearchModel.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/11.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject


/*
 "id": 55,
 "name_zh_cn": "日本",
 "name_en": "Japan",
 "image_url": "http://m.chanyouji.cn/destinations/55-portrait.jpg",
 "children": [
 */
@property (nonatomic,strong)NSNumber * codeId;
@property (nonatomic,copy)NSString *name_zh_cn;
@property (nonatomic,strong)NSArray *children;
@end
