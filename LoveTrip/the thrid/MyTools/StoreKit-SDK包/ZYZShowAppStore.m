//
//  ZYZShowAppStore.m
//  inApp_Store
//
//  Created by Jarvan on 15/01/23.
//  Copyright (c) 2015年 Jarvan. All rights reserved.
//

#import "ZYZShowAppStore.h"

@implementation ZYZShowAppStore

- (instancetype)initWithAppID:(NSString *)strAppID tager:(id)tager block:(void (^)(BOOL))block
{
    if (self = [super init]) {
        self.target = tager;
        self.ShowInAppStore = block;
        
        [self openAppWithIdentifier:strAppID];
    }
    return self;
    
}

- (void)openAppWithIdentifier:(NSString *)appId{
    // 实例化对象
    SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc]init];
    // 设置成为代理
    storeProductVC.delegate=self;
    
    [storeProductVC loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : appId} completionBlock:^(BOOL result, NSError *error) {
        if (error) {
            self.ShowInAppStore(NO);
            NSLog(@"Error %@ with User Info %@.", error, [error userInfo]);
        }
    }];
    
    [self.target presentViewController:storeProductVC animated:YES completion:nil];
}

#pragma mark - 代理方法
-(void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:^{
//        [viewController release];
    }];
    
}

@end
