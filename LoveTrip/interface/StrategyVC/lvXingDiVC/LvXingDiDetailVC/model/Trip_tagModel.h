//
//  Trip_tagModel.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/9.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Trip_tagModel : NSObject

//"id": 2219,
//"name": "清水寺印象",
//"display_count": 99,
//"attraction_contents":

//name作为组头 trip_tag下有5个元素
@property(nonatomic,copy)NSString *idStr;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *display_count;
@property(nonatomic,strong)NSMutableArray *attraction_contents;

@end
