//
//  YZYHorizListView.h
//  AutoScrollDemo
//
//  Created by YZY on 2017/9/20.
//  Copyright © 2017年 YZY. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YZYHorizListView;

@protocol YZYHorizListViewDelegate <NSObject>

- (NSInteger)numberOfItemsInHorizListView:(YZYHorizListView *)listView;

- (CGSize)horizListView:(YZYHorizListView *)listView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

- (UICollectionViewCell *)horizListView:(YZYHorizListView *)listView collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (CGFloat)horizListView:(YZYHorizListView *)listView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;

- (CGFloat)horizListView:(YZYHorizListView *)listView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

- (void)horizListView:(YZYHorizListView *)listView collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface YZYHorizListView : UIView

@property (assign) id <YZYHorizListViewDelegate> listViewDelegate;

@property (strong, nonatomic, readonly) UICollectionView *collectionView;

/*
 * 是否自动滚动 默认NO; 若开启 则在页面消失的时候 需要手动调用 stopScroll方法
 */
@property (assign, nonatomic) BOOL autoScroll;

- (void)stopScroll;

@end
