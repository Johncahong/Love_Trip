//
//  FTripdayModel.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/6.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "FTripdayModel.h"

@implementation FTripdayModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"nodes"]){
        [self setValue:value forKey:@"nodesTirp"];
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
