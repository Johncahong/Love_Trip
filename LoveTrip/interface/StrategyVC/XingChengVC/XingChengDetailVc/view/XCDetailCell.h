//
//  XCDetailCell.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/9.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCNodeModel.h"
#import "XCDetailViewController.h"

@protocol pushVCProtocol <NSObject>

-(void)pushVC:(NSString *)idStr;

@end

@interface XCDetailCell : UITableViewCell

@property(nonatomic,strong)XCNodeModel *model;

@property(nonatomic,strong)id <pushVCProtocol>delegate;
@end
