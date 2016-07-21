//
//  ZYZMyButton.h
//  03-KVC
//
//  Created by Jarvan on 15/12/24.
//  Copyright (c) 2015年 Jarvan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYZMyButton;

typedef void(^MyBlcok)(ZYZMyButton *button);

@interface ZYZMyButton : UIButton

@property (nonatomic,copy) MyBlcok buttonBlock;

/** 类方法，快速实例化按钮*/
+ (instancetype)addBlockButtonWithFrame:(CGRect)frame
                                  title:(NSString *)title
                                  image:(UIImage *)image
                                bgImage:(UIImage *)bgImage
                                    tag:(int)tag
                            actionBlock:(MyBlcok)actionBlock;
@end
