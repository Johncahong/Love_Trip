//
//  AppDelegate.h
//  LoveTrip
//
//  Created by Hello Cai on 16/3/29.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@property float autoSizeScaleX;
@property float autoSizeScaleY;

+ (void)storyBoradAutoLay:(UIView *)allView;

/**动态获取当前屏幕尺寸下控件的高度*/
+(CGFloat)getCalculatorValue_Height:(CGFloat)cgfloat;
@end

