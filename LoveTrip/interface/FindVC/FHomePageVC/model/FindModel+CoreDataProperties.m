//
//  FindModel+CoreDataProperties.m
//  LoveTrip
//
//  Created by Hello Cai on 16/5/20.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FindModel+CoreDataProperties.h"

@implementation FindModel (CoreDataProperties)

@dynamic days;
@dynamic front_cover_photo_url;
@dynamic idStr;
@dynamic name;
@dynamic photos_count;
@dynamic start_date;
@dynamic imageUrl;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"id"]){
        [self setValue:value forKey:@"idStr"];
    }
}
-(void)setValue:(id)value forKey:(NSString *)key{
    if([value isKindOfClass:[NSNull class]]){
        
        [self setValue:nil forKey:key];
    }else if([value isKindOfClass:[NSNumber class]]){
        
        [self setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
    }else{
        [super setValue:value forKey:key];
    }
}

-(void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues{
    
    for (NSString *key in keyedValues) {
        
        [self setValue:keyedValues[key] forKey:key];
        
    }
}
@end
