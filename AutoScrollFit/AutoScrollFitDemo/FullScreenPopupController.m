//
//  FullScreenPopupController.m
//  zhwp
//
//  Created by 杨志勇 on 16/8/16.
//  Copyright © 2016年 zbwx. All rights reserved.
//

#define kScreenSize [UIScreen mainScreen].bounds.size

#import "FullScreenPopupController.h"

@interface FullScreenPopupController ()
@property (nonatomic, strong) FullScreenPopupController *strongSelf;
@property (nonatomic, weak) UIImageView *bgMaskImgView;
@property (nonatomic, weak) PopupBaseView *popupView;

@end

@implementation FullScreenPopupController

- (instancetype)init {
    self = [super init];
    if (self) {
        _appearAnim = FullScreenPopAppearAnimCenter;
    }
    return self;
}

- (void)showCustomPopupView:(PopupBaseView *)popupView {
    _strongSelf = self;
    
    UIView * keyWindow = [UIApplication sharedApplication].keyWindow;
    keyWindow.frame = [UIScreen mainScreen].bounds;
    UIImageView *bgMaskImgView = [[UIImageView alloc] initWithFrame: [UIScreen mainScreen].bounds];
    bgMaskImgView.backgroundColor = [UIColor blackColor];
    [keyWindow addSubview: bgMaskImgView];
    _bgMaskImgView = bgMaskImgView;
    bgMaskImgView.userInteractionEnabled = YES;
    [bgMaskImgView addGestureRecognizer: [[UITapGestureRecognizer alloc]
                                          initWithTarget: self
                                          action: @selector(bgMaskTapAction)]];
    
    CGRect popupViewInitialRect = CGRectZero;
    
    switch (_appearAnim) {
        case FullScreenPopAppearAnimCenter: {
            popupViewInitialRect = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - popupView.frame.size.width / 2,
                                              [UIScreen mainScreen].bounds.size.height / 2 - popupView.frame.size.height / 2 - 20,
                                              
                                              popupView.frame.size.width,
                                              
                                              popupView.frame.size.height);
        }
            
            break;
            
        case FullScreenPopAppearAnimFromTop: {
            popupViewInitialRect = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - popupView.frame.size.width / 2, - popupView.frame.size.height, popupView.frame.size.width, popupView.frame.size.height);
        }
            
            break;
            
        case FullScreenPopAppearAnimFromBottom: {
            popupViewInitialRect = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - popupView.frame.size.width / 2, kScreenSize.height + popupView.frame.size.height, popupView.frame.size.width, popupView.frame.size.height);
        }
            break;
    }
    
    popupView.frame = popupViewInitialRect;
    _popupView = popupView;
    [keyWindow addSubview: popupView];
    
    /// 初始化动画
    [self initialAnim];
    
    [self showAnim];
}

- (void)bgMaskTapAction {
    _popupView.hadConfirm = NO;
    [self dismissCustomPopupView];
}

- (void)dismissCustomPopupView {

    [self dismissAnim];
}

- (void)initialAnim {
    
    switch (_appearAnim) {
        case FullScreenPopAppearAnimCenter: {
            _popupView.alpha = 0;
            _bgMaskImgView.alpha = 0;
        }
            break;
            
        case FullScreenPopAppearAnimFromBottom: {
            _bgMaskImgView.alpha = 0;

        }
            break;
            
        case FullScreenPopAppearAnimFromTop: {
            _bgMaskImgView.alpha = 0;
        }
            break;
    }
}

- (void)showAnim {
    [UIView animateWithDuration: 0.3 animations:^{
        
        switch (_appearAnim) {
            case FullScreenPopAppearAnimCenter: {
                _bgMaskImgView.alpha = 0.4;
                _popupView.alpha = 1;
            }
                break;
                
            case FullScreenPopAppearAnimFromBottom: {
                _bgMaskImgView.alpha = 0.4;
                _popupView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - _popupView.frame.size.width / 2,
                                              [UIScreen mainScreen].bounds.size.height - _popupView.frame.size.height,
                                              
                                              _popupView.frame.size.width,
                                              
                                              _popupView.frame.size.height);
            }
                break;
                
            case FullScreenPopAppearAnimFromTop: {
                _bgMaskImgView.alpha = 0.4;
                _popupView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - _popupView.frame.size.width / 2,
                                              0,
                                              
                                              _popupView.frame.size.width,
                                              
                                              _popupView.frame.size.height);
            }
                break;
        }
    }];
    
}

- (void)dismissAnim {
    [UIView animateWithDuration: 0.3 animations:^{
        
        switch (_appearAnim) {
            case FullScreenPopAppearAnimCenter: {
                _bgMaskImgView.alpha = 0;
                _popupView.alpha = 0;
            }
                
                break;
                
            case FullScreenPopAppearAnimFromTop: {
                _bgMaskImgView.alpha = 0;

                _popupView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - _popupView.frame.size.width / 2, - _popupView.frame.size.height, _popupView.frame.size.width, _popupView.frame.size.height);
            }
                
                break;
                
            case FullScreenPopAppearAnimFromBottom: {
                _bgMaskImgView.alpha = 0;
                _popupView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - _popupView.frame.size.width / 2, kScreenSize.height + _popupView.frame.size.height, _popupView.frame.size.width, _popupView.frame.size.height);
            }
                break;
        }
        
    }completion:^(BOOL finished) {
        
        [self deinit];
        
        if (self.didDismissBlock) {
            self.didDismissBlock();
        }
    }];
}

- (void)deinit {
    [_popupView removeFromSuperview];
    [_bgMaskImgView removeFromSuperview];
    _strongSelf = nil;
}

@end










