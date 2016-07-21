//
//  CollectionCell.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/7.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DestinationsModel.h"
@interface CollectionCell : UICollectionViewCell

@property(nonatomic,strong)DestinationsModel *model;
@property(nonatomic,copy)NSString *textString;

@property(nonatomic,copy)NSString *idStr;
@property(nonatomic,copy)NSString *name_zh_cn;

@end
