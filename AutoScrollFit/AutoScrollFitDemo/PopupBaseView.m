//
//  PopupBaseView.m
//  zhwp
//
//  Created by 杨志勇 on 16/8/16.
//  Copyright © 2016年 zbwx. All rights reserved.
//

#import "PopupBaseView.h"
#import "UIViewExt.h"

@implementation PopupBaseView
{
    CGRect _selfOriginRect;
    UIView *_textFieldView;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        [self setUpConfig];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self setUpConfig];
    }
    return self;
}

- (void)setUpConfig {
    _hadConfirm = NO;
    _autoScrollToAppearKeyboardEnable = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [self registerTextFieldViewClass:[UITextField class]
     didBeginEditingNotificationName:UITextFieldTextDidBeginEditingNotification
       didEndEditingNotificationName:UITextFieldTextDidEndEditingNotification];
    
    //  Registering for UITextView notification.
    [self registerTextFieldViewClass:[UITextView class]
     didBeginEditingNotificationName:UITextViewTextDidBeginEditingNotification
       didEndEditingNotificationName:UITextViewTextDidEndEditingNotification];
}

-(void)registerTextFieldViewClass:(nonnull Class)aClass
  didBeginEditingNotificationName:(nonnull NSString *)didBeginEditingNotificationName
    didEndEditingNotificationName:(nonnull NSString *)didEndEditingNotificationName {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldViewDidBeginEditing:) name:didBeginEditingNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldViewDidEndEditing:) name:didEndEditingNotificationName object:nil];
}

/*  UIKeyboardWillShowNotification. */
-(void)keyboardWillShow:(NSNotification*)aNotification {
    
    if (!_autoScrollToAppearKeyboardEnable) {
        return;
    }
    
    CGRect checkFrame = [_textFieldView.superview convertRect: _textFieldView.frame toView: nil];
    
    if (!CGRectContainsRect(self.frame, checkFrame)) {
        return;
    }
    
    NSDictionary *keyboardInfoDic = aNotification.userInfo;
    
    CGRect keyboardRect = [keyboardInfoDic[@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    
    CGFloat keyboardHeight = keyboardRect.size.height;
    
   // if (CGRectGetMaxY(checkFrame) > ([UIScreen mainScreen].bounds.size.height - keyboardHeight)) {
        
        CGFloat convertAimY = [UIScreen mainScreen].bounds.size.height - keyboardHeight;
        
        [UIView animateWithDuration: 0.2 animations:^{
            
            self.top = self.top + fabs(convertAimY - CGRectGetMaxY(checkFrame));
        }];
   // }
}

/*  UIKeyboardDidShowNotification. */
- (void)keyboardDidShow:(NSNotification*)aNotification
{
    
}

/*  UIKeyboardWillHideNotification. So setting rootViewController to it's default frame. */
- (void)keyboardWillHide:(NSNotification*)aNotification
{
    
}

/*  UIKeyboardDidHideNotification. So topViewBeginRect can be set to CGRectZero. */
- (void)keyboardDidHide:(NSNotification*)aNotification
{
    
}

#pragma mark - UITextFieldView Delegate methods
/**  UITextFieldTextDidBeginEditingNotification, UITextViewTextDidBeginEditingNotification. Fetching UITextFieldView object. */
-(void)textFieldViewDidBeginEditing:(NSNotification*)notification
{
    if (!_autoScrollToAppearKeyboardEnable) {
        return;
    }
    
    _selfOriginRect = self.frame;
    
    _textFieldView = notification.object;
}

/**  UITextFieldTextDidEndEditingNotification, UITextViewTextDidEndEditingNotification. Removing fetched object. */
-(void)textFieldViewDidEndEditing:(NSNotification*)notification
{
    if (!_autoScrollToAppearKeyboardEnable) {
        return;
    }
    
    if (self.top != _selfOriginRect.origin.y) {
        [UIView animateWithDuration: 0.2 animations:^{
            
            self.frame = _selfOriginRect;
        }];
    }
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
