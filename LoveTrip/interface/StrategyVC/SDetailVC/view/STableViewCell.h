//
//  STableViewCell.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/7.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDetailModel.h"
@interface STableViewCell : UITableViewCell

@property(nonatomic,strong)SDetailModel *model;

@property(nonatomic,copy)NSString *titleName;
@end
