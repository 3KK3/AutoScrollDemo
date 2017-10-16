//
//  PopupBaseView.h
//  zhwp
//
//  Created by 杨志勇 on 16/8/16.
//  Copyright © 2016年 zbwx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupBaseView : UIView

@property (nonatomic, assign) BOOL hadConfirm; //标记是否点击弹出框的 确认 按钮
@property (nonatomic, assign) BOOL autoScrollToAppearKeyboardEnable; //是否自动滚动来显示键盘 默认no

@end
