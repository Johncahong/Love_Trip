//
//  DatabaseManager.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/5.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FindModel.h"
@interface DatabaseManager : NSObject

+(instancetype)shareDatabase;

-(void)insertDataModel:(FindModel *)model;

-(void)deleteF1Database;

-(NSMutableArray *)searchF1Database;
@end
