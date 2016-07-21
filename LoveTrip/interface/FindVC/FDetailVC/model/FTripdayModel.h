//
//  FTripdayModel.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/6.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTripdayModel : NSObject


@property(nonatomic,copy)NSString *trip_date;
@property(nonatomic,strong)NSMutableArray *nodesTirp;

@property(nonatomic,strong)NSMutableArray *nodeArray;
@end
