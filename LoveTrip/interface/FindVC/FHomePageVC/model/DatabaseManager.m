//
//  DatabaseManager.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/5.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "DatabaseManager.h"
#import "FMDatabase.h"

@interface DatabaseManager ()

@property(nonatomic,strong)FMDatabase *database;

@end

@implementation DatabaseManager

+(instancetype)shareDatabase{

    static DatabaseManager *databaseSingle;
    if(databaseSingle ==nil){
        databaseSingle = [[DatabaseManager alloc] init];
    }
    return databaseSingle;
}

-(instancetype)init{
    if(self = [super init]){
        [self initDatabase];
    }
    return self;
}

-(void)initDatabase{
    NSString *pathStr = [NSHomeDirectory() stringByAppendingString:@"/Documents/newdb.rdb"];
    NSLog(@"path%@",pathStr);
    _database = [[FMDatabase alloc] initWithPath:pathStr];
    
    if(![_database open]){
        NSLog(@"数据库打开失败");
    }

    if(![_database executeUpdate:@"create table if not exists baseTableF1(idStr, name, front_cover_photo_url, start_date, days, photos_count, image)"]){
        NSLog(@"创建表格F1失败");
    }

}


-(void)insertDataModel:(FindModel *)model{

    NSString *str = @"insert into baseTableF1 values(?, ?,?,?,?,?,?)";
    
    if(![_database executeUpdate:str,model.idStr, model.name,model.front_cover_photo_url,model.start_date,model.days, model.photos_count, model.imageUrl]){
        NSLog(@"表格F1插入数据失败");
    }
}


-(void)deleteF1Database{
    NSString *str = @"delete from baseTableF1";
    if(![_database executeUpdate:str]){
        NSLog(@"表格F1数据删除失败");
    }
}



-(NSMutableArray *)searchF1Database{
    NSString *str = @"select * from baseTableF1";
    FMResultSet *resultSet = [_database executeQuery:str];
    
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    while([resultSet next]){
        FindModel *model =[[FindModel alloc] init];
        model.idStr = [resultSet stringForColumn:@"idStr"];
        model.name = [resultSet stringForColumn:@"name"];
        model.front_cover_photo_url = [resultSet stringForColumn:@"front_cover_photo_url"];
        model.start_date = [resultSet stringForColumn:@"start_date"];
        model.days = [resultSet stringForColumn:@"days"];
        model.photos_count = [resultSet stringForColumn:@"photos_count"];
        model.imageUrl = [resultSet stringForColumn:@"image"];
        
        [newArray addObject:model];
    }
    return newArray;
}

@end
