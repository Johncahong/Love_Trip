//
//  FindCell.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/5.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindModel.h"

@interface FindCell : UITableViewCell

@property(nonatomic,strong)FindModel *model;
@property(nonatomic,copy)NSString *idStr;

@end
