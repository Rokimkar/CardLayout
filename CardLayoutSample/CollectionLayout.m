//
//  CollectionLayout.m
//  CardLayoutSample
//
//  Created by Sanchit Kumar Singh on 7/1/16.
//  Copyright © 2016 Sanchit Kumar Singh. All rights reserved.
//

#import "CollectionLayout.h"


@implementation CollectionLayout
{
    NSIndexPath *mainIndexPath;
}

-(void)prepareLayout{
    [super prepareLayout];
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
     UICollectionViewLayoutAttributes *attributes = [[super layoutAttributesForItemAtIndexPath:indexPath] copy];
    CATransform3D theTransform = CATransform3DIdentity;
    const CGFloat theScale = 1.05f;
    theTransform = CATransform3DScale(theTransform, theScale, theScale, 1.0f);
    attributes.transform3D=theTransform;
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *attributesSuper = [super layoutAttributesForElementsInRect:rect];
    NSArray *attributes = [[NSArray alloc]initWithArray:attributesSuper copyItems:YES];
    NSArray *cellIndices = [self.collectionView indexPathsForVisibleItems];
    NSIndexPath *neededIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    for(NSInteger i=0;i<cellIndices.count;i++){
        NSIndexPath *indexPath = [cellIndices objectAtIndex:i];
        if(indexPath.row>neededIndexPath.row){
            neededIndexPath=indexPath;
        }
        NSLog(@"%ld,%ld",(long)indexPath.row,(long)indexPath.section);
    }
    if(cellIndices.count==0){
        mainIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }else{
        if(neededIndexPath.row>0)
            mainIndexPath = [NSIndexPath indexPathForRow:neededIndexPath.row-1 inSection:0];
    }
    
    for (UICollectionViewLayoutAttributes *attribute in attributes)
    {
        [self applyTransformToLayoutAttributes:attribute];
    }
    return attributes;
}

-(void) applyTransformToLayoutAttributes:(UICollectionViewLayoutAttributes *)attribute{
    if(attribute.indexPath.row == mainIndexPath.row){
        attribute.size = CGSizeMake(self.collectionView.bounds.size.width-40, self.collectionView.bounds.size.height);
        attribute.zIndex+=10;
    }
}

#pragma mark - Transform related

@end
