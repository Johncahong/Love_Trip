//
//  FDetailCell.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/6.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNodeTripModel.h"
#import "FNodesSubModel.h"
@interface FDetailCell : UITableViewCell


@property(nonatomic,strong)FNodesSubModel *nodeSubmodel;
@property(nonatomic,copy)void(^pushShowBlock)(UIImage *image,int width, int height);
@end
