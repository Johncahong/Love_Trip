//
//  MessageVC.m
//  LoveTrip
//
//  Created by Hello Cai on 16/5/6.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "MessageVC.h"

@interface MessageVC ()

@property (weak, nonatomic) IBOutlet UILabel *labelText;
@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    ZYZMyButton *button = [ZYZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 50, 40) title:nil image:[UIImage imageNamed:@"ButtonBack_normal.png"] bgImage:nil tag:100 actionBlock:^(ZYZMyButton *button) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [button setImage:[UIImage imageNamed:@"ButtonBack_pressed.png"] forState:UIControlStateSelected];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //设置边框
    _labelText.layer.borderColor = [UIColor grayColor].CGColor;
    _labelText.layer.borderWidth = 0.5;
    //设置圆弧
    _labelText.layer.masksToBounds = YES;
    _labelText.layer.cornerRadius = 8;
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
