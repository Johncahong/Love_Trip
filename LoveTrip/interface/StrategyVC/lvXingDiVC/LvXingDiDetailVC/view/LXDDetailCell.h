//
//  LXDDetailCell.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/9.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttractionModel.h"

@protocol pushShowVCProtocol <NSObject>

-(void)pushShowVC:(UIImage *)image width:(int)width heigth:(int)heigth;
@end

@interface LXDDetailCell : UITableViewCell

@property(nonatomic,strong)AttractionModel *attmodel;
@property(nonatomic,weak)id <pushShowVCProtocol>delegate;
@end
