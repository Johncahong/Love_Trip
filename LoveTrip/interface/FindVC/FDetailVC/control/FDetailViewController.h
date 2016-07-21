//
//  FDetailViewController.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/5.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDetailViewController : UIViewController

@property(nonatomic,copy)NSString *idStr;
@property(nonatomic,copy)void(^refreshLoveVCBlock)(void);
@end
