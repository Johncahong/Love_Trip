//
//  LXDImageModel.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/9.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "LXDImageModel.h"

@implementation LXDImageModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"id"]){
        [self setValue:value forKey:@"idStr"];
    }else if ([key isEqualToString:@"description"]){
        [self setValue:value forKey:@"descriptionStr"];
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

@end
