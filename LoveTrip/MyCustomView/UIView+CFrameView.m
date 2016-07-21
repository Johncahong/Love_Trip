//
//  UIView+CFrameView.m
//  GreatDiscount
//
//  Created by Hello Cai on 16/4/17.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "UIView+CFrameView.h"

@implementation UIView (CFrameView)


-(void)setWidth:(CGFloat)width{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

-(CGFloat)width{
    
    return self.frame.size.width;
}

-(void)setHeight:(CGFloat)height{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(void)setX:(CGFloat)x{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

-(CGFloat)x{
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

-(CGFloat)y{
    return self.frame.origin.y;
}
@end
