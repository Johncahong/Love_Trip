//
//  ShowImageVC.m
//  LoveTrip
//
//  Created by Hello Cai on 16/5/3.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import "ShowImageVC.h"

@interface ShowImageVC ()
@property(nonatomic,strong)UIImageView *mainImageV;
@end

@implementation ShowImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor blackColor];
    [self createImageView];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}
-(void)createImageView{
    _mainImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, ScreenWidth *_imgV_H *1.0 /_imgV_W)];
    [self.view addSubview:_mainImageV];
    
    _mainImageV.image = _image;
    _mainImageV.center =self.view.center;
    _mainImageV.userInteractionEnabled =YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
}

-(void)tapAction:(UITapGestureRecognizer *)tap{
    [self.navigationController popViewControllerAnimated:YES];
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
