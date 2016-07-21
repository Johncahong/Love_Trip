//
//  SearchDetailModel.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/11.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchDetailModel : NSObject
/*

*/
@property (nonatomic,strong)NSNumber *codeId;
@property (nonatomic,  copy)NSString *name;
@property (nonatomic,strong)NSNumber *photos_count;
@property (nonatomic,  copy)NSString *start_date;
@property (nonatomic,strong)NSNumber *days;
@property (nonatomic,strong)NSString *front_cover_photo_url;
@property (nonatomic,strong)NSDictionary *user;
@end
