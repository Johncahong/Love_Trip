//
//  CoredataDatabase.m
//  LoveTrip
//
//  Created by Hello Cai on 16/5/20.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "CoredataDatabase.h"
#import "AppDelegate.h"

@interface CoredataDatabase ()
@property(nonatomic,strong)NSManagedObjectContext *managedObjectContext;

@end
@implementation CoredataDatabase

-(NSManagedObjectContext *)managedObjectContext{
    if(!_managedObjectContext){
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        _managedObjectContext = app.managedObjectContext;
    }
    return _managedObjectContext;
}

static CoredataDatabase *single = nil;

+(instancetype)shareSingleton{
    
    static dispatch_once_t token = 0;
    dispatch_once(&token, ^{
        single = [[CoredataDatabase alloc] init];
    });
    return single;
    
}

//实例化对象时，如果调用了alloc方法，系统会调用allocWithZone
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    if(!single){
        single = [super allocWithZone:zone];
    }
    return single;
}

//插入
-(FindModel *)insertFindModelDict:(NSDictionary *)dict{
    
    FindModel *model = [NSEntityDescription insertNewObjectForEntityForName:@"FindModel" inManagedObjectContext:self.managedObjectContext];
    [model setValuesForKeysWithDictionary:dict];
    NSError *error = nil;
    if(error){
        [self.managedObjectContext save:&error];
    }
    return model;
    
}

-(void)deleteFindModel:(FindModel *)model{
    

    [self.managedObjectContext deleteObject:model];
    NSError *error = nil;
    if(![self.managedObjectContext save:&error] ){
        NSLog(@"deleteError:%@",[error description]);
    }
}


-(NSArray *)searchDatabase{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FindModel" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSArray *searchArr = [self.managedObjectContext executeFetchRequest:request error:&error];
    if(error){
        NSLog(@"deleteError:%@",[error description]);
    }
    return searchArr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
