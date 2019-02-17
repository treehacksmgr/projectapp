//
//  PostCollectionViewController.m
//  app3
//
//  Created by Ginger Dudley on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//

#import "PostCollectionViewController.h"
#import "OCTCollectionViewCell.h"

static NSString *const kReuseCellID = @"reuseCellID";
static NSString *const kImgName = @"img_";
static const NSInteger kTotalImgs = 10;

@interface PostCollectionViewController () <UICollectionViewDataSource>

@end

@implementation PostCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = [self.collectionView.collectionViewLayout description];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(8, 8, 8, 8);
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([OCTCollectionViewCell class]) bundle:nil]
          forCellWithReuseIdentifier:kReuseCellID];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 13;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    int imgNumber = indexPath.item % kTotalImgs + 1;
    NSString *imageName = [NSString stringWithFormat:@"%@%d", kImgName, imgNumber];
    
    OCTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseCellID forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:imageName];
    
    return cell;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self.collectionView.collectionViewLayout invalidateLayout];
}

@end
