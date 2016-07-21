//
//  FindModel+CoreDataProperties.h
//  LoveTrip
//
//  Created by Hello Cai on 16/5/20.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FindModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FindModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *days;
@property (nullable, nonatomic, retain) NSString *front_cover_photo_url;
@property (nullable, nonatomic, retain) NSString *idStr;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *photos_count;
@property (nullable, nonatomic, retain) NSString *start_date;
@property (nullable, nonatomic, retain) NSString *imageUrl;

@end

NS_ASSUME_NONNULL_END
