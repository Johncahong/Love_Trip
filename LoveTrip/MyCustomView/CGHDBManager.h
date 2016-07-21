//
//  CGHDBManager.h
//  LoveTrip
//
//  Created by Hello Cai on 16/5/7.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGHDBManager : NSObject

+(instancetype)shareDBManager;

-(void)insertDbWithModel:(id)model;

-(void)removeTableDataWithModel:(id)model;

-(void)deleteDbWithModel:(id)model;

-(NSMutableArray *)selectWithModel:(id)model;

-(BOOL)selectWithModel:(id)model whereWithDict:(NSDictionary*)dict;
@end
