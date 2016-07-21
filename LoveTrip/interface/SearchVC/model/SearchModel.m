//
//  SearchModel.m
//  LoveTrip
//
//  Created by Hello Cai on 16/4/11.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel

#pragma mark重写方法，KVC解析赋值
- (void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues{
    
    for (NSString * key in keyedValues) {
        [self setValue:keyedValues[key] forKey:key];
    }
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.codeId = value;
        
    }
    
}
-(id)valueForUndefinedKey:(NSString *)key{
    
    return nil;
}

@end
