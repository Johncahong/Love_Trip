//
//  XCCell.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/8.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCModel.h"
@interface XCCell : UITableViewCell

@property(nonatomic,strong)XCModel *model;
@property(nonatomic,copy)NSString *idStr;
@end
