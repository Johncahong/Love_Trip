//
//  ZYZShowAppStore.m
//  inApp_Store
//
//  Created by Jarvan on 15/01/23.
//  Copyright (c) 2015年 Jarvan. All rights reserved.
//

/*
 使用本类需要添加StoreKit.framework
 iOS6下模拟器可以正常显示
 
 iOS7下会右报错信息为code5，需要真机才可以进行
 */

/*示例代码
 // @"722634778" 是你的应用ID
 ZYZShowAppStore *show=[[ZYZShowAppStore alloc] initWithAppID:@"722634778" tager:self Block:^(BOOL isSucceed) {
    NSLog(@"%d",isSucceed);
 }];
 */
#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@interface ZYZShowAppStore : NSObject<SKStoreProductViewControllerDelegate>

@property(nonatomic,assign) id target;
@property(nonatomic,copy) void(^ShowInAppStore)(BOOL);

-(instancetype)initWithAppID:(NSString *)strAppID tager:(id)tager block:(void (^)(BOOL))block;

@end
