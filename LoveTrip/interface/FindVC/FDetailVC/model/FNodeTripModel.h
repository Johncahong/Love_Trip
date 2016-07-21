//
//  FNodeTripModel.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/6.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNodeTripModel : NSObject

@property(nonatomic,copy)NSString *comment;
@property(nonatomic,copy)NSString *entry_name;
@property(nonatomic,retain)NSMutableArray *notesSub;

@end
