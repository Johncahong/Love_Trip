//
//  FDetailModel.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/6.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDetailModel : NSObject

//—name 写给心爱的伦敦
//—photos_count 127
//—start_date 2012-11-14
//—user:(nsdictionary)
//— image: url
//
//—trip_days:
@property(nonatomic,copy)NSString *idStr;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *photos_count;
@property(nonatomic,copy)NSString *start_date;
@property(nonatomic,retain)NSDictionary *user;
@property(nonatomic,copy)NSString *front_cover_photo_url;
@property(nonatomic,retain)NSMutableArray *trip_days;
@end
