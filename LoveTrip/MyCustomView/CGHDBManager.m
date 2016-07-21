//
//  CGHDBManager.m
//  LoveTrip
//
//  Created by Hello Cai on 16/5/7.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "CGHDBManager.h"
#import "FMDatabase.h"
//线程安全
#import "FMDatabaseQueue.h"
#import <objc/runtime.h>

@interface CGHDBManager ()

@property(nonatomic,strong)FMDatabaseQueue *databaseQueue;

@end

static CGHDBManager *single = nil;
@implementation CGHDBManager

+(instancetype)shareDBManager{
    static dispatch_once_t oneToken=0;
    dispatch_once(&oneToken, ^{
        single = [[CGHDBManager alloc] init];
    });
    return single;
}

// 当实例化一个对象的时候,如果调用了alloc方法,系统就会调用 allocWithZone
// zone 就代表一片内存
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t oneToken=0;
    dispatch_once(&oneToken, ^{
        single = [super allocWithZone:zone];
    });
    return single;
}

#pragma mark - 重写父类的方法
-(instancetype)init{
    if(self = [super init]){
        //打开数据库
        NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/cghDB.rdb"];
        _databaseQueue = [[FMDatabaseQueue alloc] initWithPath:path];
        NSLog(@"path:%@",path);
    }
    return self;
}

#pragma mark - 获取模型属性
-(NSArray *)getPropertyListWithTable:(NSString *)tableName{
    //tableName是模型的类名字符串形式
    NSMutableArray *propertyArray = [NSMutableArray array];
    
    //用来获取模型属性(成员变量)个数
    unsigned int count = 0;
    Ivar *vars = class_copyIvarList(NSClassFromString(tableName), &count);
    
    for(int i=0; i<count;i++){
        Ivar var = vars[i];
        //获取属性名
        NSString *propertyStr = [NSString stringWithUTF8String:ivar_getName(var)];
        [propertyArray addObject:propertyStr];
    }
    return propertyArray;
}

#pragma mark - 创建表格
-(void)createTableName:(NSString *)tableName{
    //表格名就是模型的类名
    NSArray *propertyArray = [self getPropertyListWithTable:tableName];
    
    //数据库语句字段的拼接
    NSMutableString *mString = [NSMutableString string];
    for (int i =0; i<propertyArray.count; i++) {
        if(i==0){
            [mString appendFormat:@"%@",propertyArray[i]];
        }else{
            [mString appendFormat:@",%@",propertyArray[i]];
        }
    }
    //数据库创建表格语句
    NSString *sql = [NSString stringWithFormat:@"create table if not exists %@(%@)",tableName,mString];
    [_databaseQueue inDatabase:^(FMDatabase *db) {
        if(![db executeUpdate:sql]){
            NSLog(@"创建表格失败");
        }
    }];
}

#pragma mark - 插入
/** 插入数据*/
-(void)insertDbWithModel:(id)model{
    //找到实例化对象的类名
    NSString *tableName = [NSString stringWithUTF8String:object_getClassName(model)];
    NSArray *propertyArray = [self getPropertyListWithTable:tableName];
    [self createTableName:tableName];
    
    NSMutableString *tempString = [NSMutableString string];
    NSMutableArray *valueArray = [NSMutableArray array];
    for (int i = 0; i<propertyArray.count; i++) {
        //将values(?,?)对应的值存入数组中
        if(i==0){
            [tempString appendFormat:@"?"];
        }else{
            [tempString appendFormat:@",?"];
        }
        
        if([model valueForKey:propertyArray[i]]==nil){
            [valueArray addObject:@""];
        }else{
            [valueArray addObject:[model valueForKey:propertyArray[i]]];
        }
    }
    //数据库插入语句
    NSString *sql = [NSString stringWithFormat:@"insert into %@ values(%@)",tableName,tempString];

    [_databaseQueue inDatabase:^(FMDatabase *db) {
        if(![db executeUpdate:sql withArgumentsInArray:valueArray]){
            NSLog(@"插入失败");
            
        }else{
            NSLog(@"插入成功");
        }
    }];
}

/** 删除表中的一条数据[用在收藏上面]*/
-(void)deleteDbWithModel:(id)model{
    NSString *tableName = [NSString stringWithUTF8String:object_getClassName(model)];
    NSArray *propertyArray = [self getPropertyListWithTable:tableName];
    
    NSMutableString *keyString = [NSMutableString string];
    NSMutableArray *valueArray = [NSMutableArray array];
    for (int i = 0; i<propertyArray.count; i++) {
        //删除数据：delete from Model where name=? and price=?
        if(i==0){
            [keyString appendFormat:@"%@=?",propertyArray[i]];
        }
//            else{
//            //注意这里的空格
//            [keyString appendFormat:@" and %@=?",propertyArray[i]];
//        }
        if([model valueForKey:propertyArray[0]]==nil){
            [valueArray addObject:@""];
        }else{
            [valueArray addObject:[model valueForKey:propertyArray[0]]];
        }
    }
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@",tableName,keyString];

    [_databaseQueue inDatabase:^(FMDatabase *db) {
        //执行sql语句是如何带入参数
        if (![db executeUpdate:sql withArgumentsInArray:valueArray]) {
            NSLog(@"删除数据失败");
        }else{
            NSLog(@"删除数据成功");
        }
    }];
}

/**删除表中的全部数据*/

-(void)removeTableDataWithModel:(id)model{
    NSString *tableName = [NSString stringWithUTF8String:object_getClassName(model)];
    NSString *sql = [NSString stringWithFormat:@"delete from %@",tableName];
    [_databaseQueue inDatabase:^(FMDatabase *db) {
        if (![db executeUpdate:sql]) {
            NSLog(@"删除所有数据失败");
        }else{
            NSLog(@"删除所有数据成功");
        }
    }];
}

/**查找数据*/
-(NSMutableArray *)selectWithModel:(id)model{
    
    NSMutableArray *selectArray = [NSMutableArray array];
    NSString *tableName = [NSString stringWithUTF8String:object_getClassName(model)];
    NSString *sql = [NSString stringWithFormat:@"select * from %@",tableName];
    NSArray *propertyArray = [self getPropertyListWithTable:tableName];
    
    [_databaseQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            Class class = NSClassFromString(tableName);
            id modelIn = [[class alloc] init];
            for (int i=0; i<propertyArray.count; i++) {
                [modelIn setValue:[resultSet stringForColumn:propertyArray[i]] forKey:propertyArray[i]];
            }
            [selectArray addObject:modelIn];
        }
    }];
    return selectArray;
}

/**按条件查询*/
-(BOOL)selectWithModel:(id)model whereWithDict:(NSDictionary*)dict{
    __block BOOL isSucceed = NO;
    NSString *tableName = [NSString stringWithUTF8String:object_getClassName(model)];
    //判断表格是否存在，不存在就不用往下查找了
    if(![self isTableExist:tableName]){
        return NO;
    }

    for (NSString *key in dict) {
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where _%@ = '%@'",tableName,key,dict[key]];
        [_databaseQueue inDatabase:^(FMDatabase *db) {
            FMResultSet *result = [db executeQuery:sql];
            while ([result next]) {
                isSucceed = YES;
            }
        }];
    }
    return isSucceed;
}

/**判断表格是否存在*/
- (BOOL)isTableExist:(NSString *)tableName{
    __block BOOL isExits = NO;
    [_databaseQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
        while ([rs next])
        {
            // just print out what we've got in a number of formats.
            NSInteger count = [rs intForColumn:@"count"];
            //            NSLog(@"isTableOK %ld", (long)count);
            
            if (0 == count)
            {
                isExits = NO;           //return NO
                break;
            }
            else
            {
                isExits = YES;          //return YES
                break;
            }
        }
        [rs close];
    }];
    return isExits;
}

@end
