//
//  FImageModel.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/6.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "FImageModel.h"

@implementation FImageModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
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