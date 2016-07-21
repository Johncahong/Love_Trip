//
//  LXDCollectionCell.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/9.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXDImageModel.h"
#import "LXDDetailViewController.h"
@interface LXDCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;


@property(nonatomic,strong)LXDImageModel *model;

@property(nonatomic,weak)LXDDetailViewController *nav;
@end
