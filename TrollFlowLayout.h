//
//  TrollFlowLayout.h
//  UIDemo
//
//  Created by Troll on 16/9/21.
//  Copyright © 2016年 Troll. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TrollFlowLayout;

@protocol TrollFlowLayoutDelegate <NSObject>

- (CGSize)collectionView:(UICollectionView *)collectionView withLayout:(TrollFlowLayout *)layout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface TrollFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) id<TrollFlowLayoutDelegate> delegate;

@end
