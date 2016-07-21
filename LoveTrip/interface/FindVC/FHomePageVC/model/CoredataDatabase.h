//
//  CoredataDatabase.h
//  LoveTrip
//
//  Created by Hello Cai on 16/5/20.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindModel.h"
@interface CoredataDatabase : UIImageView

+(instancetype)shareSingleton;

//插入数据
-(FindModel *)insertFindModelDict:(NSDictionary *)dict;

//删除数据
-(void)deleteFindModel:(FindModel *)model;

//查询
-(NSArray *)searchDatabase;
@end
