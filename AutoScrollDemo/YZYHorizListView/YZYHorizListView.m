//
//  YZYHorizListView.m
//  AutoScrollDemo
//
//  Created by YZY on 2017/9/20.
//  Copyright © 2017年 YZY. All rights reserved.
//

#import "YZYHorizListView.h"

//滚动时间
static CGFloat const ScrollTimeInterval = 0.4;

//滚动距离
static CGFloat const ScrollDistance = 15.0;

@interface YZYHorizListView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSTimer *_scrollTimer;
    UICollectionViewFlowLayout *_layout;
}

@end

@implementation YZYHorizListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        
        [self createUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder: aDecoder]) {
        [self createUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _collectionView.frame = self.bounds;
}

- (void)setAutoScroll:(BOOL)autoScroll {
    _autoScroll = autoScroll;
    
    [self judgeScrollCondition];
}

- (void)judgeScrollCondition {
    
    if (_scrollTimer) {
        return;
    }
    
    NSInteger itemCount = [self.listViewDelegate numberOfItemsInHorizListView: self];
    
    CGSize size = [self.listViewDelegate horizListView: self layout: _layout sizeForItemAtIndexPath: [NSIndexPath indexPathForItem:0 inSection:0 ]];
    
    if (_autoScroll && itemCount  > 1 && (itemCount * size.width > self.frame.size.width) ) {
        [self startScroll];
    }
}

- (void)startScroll {
    [self stopScroll];
    
    _scrollTimer = [NSTimer scheduledTimerWithTimeInterval: ScrollTimeInterval target: self selector: @selector(timerAutoScroll) userInfo: nil repeats: YES];
    
    [[NSRunLoop mainRunLoop] addTimer:_scrollTimer forMode:NSRunLoopCommonModes];
    
    //立即启动定时器
    [_scrollTimer setFireDate:[NSDate date]];
}

- (void)timerAutoScroll {

    if (self.collectionView.contentOffset.x >= (self.collectionView.contentSize.width - self.collectionView.frame.size.width)) {
        
        // 10 point距离 防止卡顿
        self.collectionView.contentOffset = CGPointMake(10, 0);
    }
    
    //切割每次动画滚动距离
    [UIView animateWithDuration: ScrollTimeInterval delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.collectionView.contentOffset = CGPointMake(self.collectionView.contentOffset.x + ScrollDistance, self.collectionView.contentOffset.y);
    } completion:nil];
}

- (void)stopScroll {
    if (_scrollTimer) {
        [_scrollTimer invalidate];
        _scrollTimer = nil;
    }
}

- (void)createUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _layout = layout;
    
    _collectionView = [[UICollectionView alloc] initWithFrame: self.bounds collectionViewLayout: layout];
    [self addSubview: _collectionView];
    _collectionView.delegate = self;;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger count = [self.listViewDelegate numberOfItemsInHorizListView: self];
    
    return (count + 1);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize size = [self.listViewDelegate horizListView: self layout: collectionViewLayout sizeForItemAtIndexPath: indexPath];
    return size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == [self.listViewDelegate numberOfItemsInHorizListView: self]) {
        return [self.listViewDelegate horizListView: self collectionView: collectionView cellForItemAtIndexPath: [NSIndexPath indexPathForItem:0 inSection: indexPath.section]];
    }
    
    return [self.listViewDelegate horizListView: self collectionView: collectionView cellForItemAtIndexPath: indexPath];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    if ([self.listViewDelegate respondsToSelector: @selector(horizListView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        return [self.listViewDelegate horizListView: self layout: collectionViewLayout minimumLineSpacingForSectionAtIndex: section];
    } else {
        return 0.00;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    if ([self.listViewDelegate respondsToSelector: @selector(horizListView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        return [self.listViewDelegate horizListView: self layout: collectionViewLayout minimumInteritemSpacingForSectionAtIndex: section];
    } else {
        return 0.00;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.listViewDelegate respondsToSelector: @selector(horizListView:collectionView:didSelectItemAtIndexPath:)]) {
        
        if (indexPath.item == [self.listViewDelegate numberOfItemsInHorizListView: self]) {
            
            [self.listViewDelegate horizListView: self collectionView:collectionView didSelectItemAtIndexPath: [NSIndexPath indexPathForItem:0 inSection: indexPath.section]];
        }
        [self.listViewDelegate horizListView: self collectionView:collectionView didSelectItemAtIndexPath: indexPath];
    }
}


@end
