//
//  TrollFlowLayout.m
//  UIDemo
//
//  Created by Troll on 16/9/21.
//  Copyright © 2016年 Troll. All rights reserved.
//

#import "TrollFlowLayout.h"

@interface TrollFlowLayout()

@property (nonatomic, strong) NSMutableArray *attributesArray;

@end

@implementation TrollFlowLayout

- (void)prepareLayout{
    
    NSAssert(_delegate != nil, @"TrollFlowLayout delegate can't be nil");
    
    [super prepareLayout];
    //总Cell个数
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    CGFloat xOffset = self.sectionInset.left;
    CGFloat yOffset = self.sectionInset.top;
    CGFloat xNextOffset = self.sectionInset.left;
    CGFloat lastHeight = 0;
    
    _attributesArray = [NSMutableArray array];
    
    for (NSInteger i=0; i<itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        CGSize itemSize = [_delegate collectionView:self.collectionView withLayout:self sizeForItemAtIndexPath:indexPath];
        
        xNextOffset+=(self.minimumInteritemSpacing + itemSize.width);
        if (xNextOffset > [self collectionView].bounds.size.width - self.sectionInset.right) {
            xOffset = self.sectionInset.left;
            xNextOffset = (self.sectionInset.left + self.minimumInteritemSpacing + itemSize.width);
            yOffset += (lastHeight + self.minimumLineSpacing);
        }
        else
        {
            xOffset = xNextOffset - (self.minimumInteritemSpacing + itemSize.width);
        }
        
        lastHeight = itemSize.height;
        
        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attribute.frame = CGRectMake(xOffset, yOffset, itemSize.width, itemSize.height);
        
        [_attributesArray addObject:attribute];
    }
}

- (CGSize)collectionViewContentSize{
    UICollectionViewLayoutAttributes *attribute = _attributesArray.lastObject;
    return CGSizeMake(self.collectionView.frame.size.width, attribute.frame.origin.y+attribute.frame.size.height+self.minimumLineSpacing);
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return [self.attributesArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
        return CGRectIntersectsRect(rect, [evaluatedObject frame]);
    }]];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return _attributesArray[indexPath.row];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return  NO;
}

@end
