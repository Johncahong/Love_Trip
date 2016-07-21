//
//  SearchDetailCell.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/11.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchDetailModel.h"
@interface SearchDetailCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;

@property (strong, nonatomic) SearchDetailModel *model;
@end
