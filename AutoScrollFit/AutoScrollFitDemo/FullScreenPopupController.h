//
//  FullScreenPopupController.h
//  zhwp
//
//  Created by 杨志勇 on 16/8/16.
//  Copyright © 2016年 zbwx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PopupBaseView.h"

typedef NS_ENUM(NSInteger , FullScreenPopAppearAnim) {
    FullScreenPopAppearAnimCenter,      // 从中间出现 默认
    FullScreenPopAppearAnimFromBottom,  // 从底部出现
    FullScreenPopAppearAnimFromTop      // 从顶端出现
};

@interface FullScreenPopupController : NSObject

@property (assign) FullScreenPopAppearAnim appearAnim;  // 默认从中间出现

@property (copy) void (^didDismissBlock)();  //消失动画结束后回调

- (void)showCustomPopupView:(PopupBaseView *)popupView;

- (void)dismissCustomPopupView;

//开户弹框需要
- (void)initialAnim;
- (void)showAnim;

@end
