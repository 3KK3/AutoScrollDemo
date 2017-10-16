//
//  ViewController.m
//  AutoScrollFitDemo
//
//  Created by YZY on 2017/10/16.
//  Copyright © 2017年 YZY. All rights reserved.
//

#import "ViewController.h"
#import "FullScreenPopupController.h"
#import "CustomPopView.h"

@interface ViewController ()
{
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];




}

- (IBAction)showAction:(id)sender {
    
    FullScreenPopupController *controller = [[FullScreenPopupController alloc] init];
    
    CustomPopView *popView = [[NSBundle mainBundle] loadNibNamed: @"CustomPopView" owner: nil options: nil].firstObject;
    popView.autoScrollToAppearKeyboardEnable = YES;
    
    [controller showCustomPopupView: popView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
