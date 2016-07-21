//
//  FNodesSubModel.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/6.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNodesSubModel : NSObject

//value1— comment 文字部分：如果要用一个词
//—entry_name  伦敦
//— notes:(array)2
//value0——description  文字部分  waterloo火车站
//— photo:(nsdictionary)
//－－url:图片
//－－image_width
//－－image_height


@property(nonatomic,copy)NSString *descriptionStr;
@property(nonatomic,strong)NSMutableArray *photo;
@property(nonatomic,copy)NSString *comment;
@property(nonatomic,copy)NSString *entry_name;

@end
