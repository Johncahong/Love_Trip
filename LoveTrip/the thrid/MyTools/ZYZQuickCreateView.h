//
//  ZYZQuickCreateView.h
//  03-KVC
//
//  Created by Jarvan on 15/12/24.
//  Copyright (c) 2015年 Jarvan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYZQuickCreateView : UIView

/** 快速创建系统按键*/
+ (UIButton *)addSystemButtonWithFrame:(CGRect)frame
                                 title:(NSString *)title
                                   tag:(int)tag
                                target:(id)target
                                action:(SEL)action;

/** 快速创建图片按键*/
+ (UIButton *)addCustomButtonWithFrame:(CGRect)frame
                                 title:(NSString *)title
                                 image:(UIImage *)image
                               bgImage:(UIImage *)bgImage
                                   tag:(int)tag
                                target:(id)target
                                action:(SEL)action;

/** 快速创标签*/
+ (UILabel *)addLableWithFrame:(CGRect)frame
                          text:(NSString *)text
                     textColor:(UIColor *)color;

/** 快速图片视图*/
+ (UIImageView *)addImageViewWithFrame:(CGRect)frame
                                 image:(UIImage *)image;

@end
