//
//  ViewController.m
//  AutoScrollDemo
//
//  Created by YZY on 2017/9/20.
//  Copyright © 2017年 YZY. All rights reserved.
//

#import "ViewController.h"
#import "YZYHorizListView.h"

static NSString *const kCellIdentifier = @"HorizCellIdentifier";

@interface ViewController () <YZYHorizListViewDelegate>
{
    YZYHorizListView *_horizListView;
    NSArray *_broadcastArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _broadcastArray = @[@"☂️12312313131",
                        @"大家上午好哈啊哈哈😝"
                        ];

    _horizListView = [[YZYHorizListView alloc] initWithFrame: CGRectMake(40, 10, [UIScreen mainScreen].bounds.size.width - 80, [UIScreen mainScreen].bounds.size.height - 20)];
    _horizListView.listViewDelegate = self;
    [_horizListView.collectionView registerClass: [UICollectionViewCell class] forCellWithReuseIdentifier: kCellIdentifier];
    [self.view addSubview: _horizListView];
    _horizListView.backgroundColor = [UIColor lightGrayColor];
    
    _horizListView.autoScroll = YES;
    [_horizListView.collectionView reloadData];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    
    // 注意在页面消失的时候 手动调用停止计时器
    [_horizListView stopScroll];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --- YZYHorizListViewDelegate
- (NSInteger)numberOfItemsInHorizListView:(YZYHorizListView *)listView {
    
    return _broadcastArray.count;
}

- (CGSize)horizListView:(YZYHorizListView *)listView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return _horizListView.frame.size;
    
}

- (UICollectionViewCell *)horizListView:(YZYHorizListView *)listView collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: kCellIdentifier forIndexPath: indexPath];
    
    NSInteger tag = 1008611;
    [[cell viewWithTag: tag] removeFromSuperview];
    
    UILabel *label = [[UILabel alloc] initWithFrame: _horizListView.bounds];
    [cell addSubview: label];
    label.tag = tag;
    [label setText: _broadcastArray[indexPath.item]];
    
    return cell;
}


@end
