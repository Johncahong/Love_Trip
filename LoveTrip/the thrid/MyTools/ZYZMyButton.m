//
//  ZYZMyButton.m
//  03-KVC
//
//  Created by Jarvan on 15/12/24.
//  Copyright (c) 2015年 Jarvan. All rights reserved.
//

#import "ZYZMyButton.h"

@implementation ZYZMyButton

+ (instancetype)addBlockButtonWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image bgImage:(UIImage *)bgImage tag:(int)tag actionBlock:(MyBlcok)actionBlock{
    ZYZMyButton *button = [ZYZMyButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    
    button.tag = tag;
    button.buttonBlock = actionBlock;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (void)buttonClick:(ZYZMyButton *)button{
    if (button.buttonBlock) {
        button.buttonBlock(button);
    }
}


@end
