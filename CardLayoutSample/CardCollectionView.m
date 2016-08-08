//
//  CardCollectionView.m
//  CardLayoutSample
//
//  Created by Sanchit Kumar Singh on 6/30/16.
//  Copyright © 2016 Sanchit Kumar Singh. All rights reserved.
//

#import "CardCollectionView.h"
#import "CollectionViewCell.h"
#import "BlankCell.h"
#define TRANSFORM_CELL_VALUE CGAffineTransformMakeScale(0.8, 0.8)
#define ANIMATION_SPEED 0.2

@interface CardCollectionView()
@property(strong,nonatomic) NSArray *dataArray;
@end

@implementation CardCollectionView

-(id)initWithFrame:(CGRect)frame data:(NSArray *)dataArray{
    [self setUpCollectionViewFlowLayout];
    [self.layout setItemSize:CGSizeMake(frame.size.width-80, frame.size.height-20)];
    self = [super initWithFrame:frame collectionViewLayout:self.layout];
    if(self){
        self.dataSource = self;
        self.delegate = self;
        self.dataArray = dataArray;
    }
    [self registerCellsForCollectionView];
    [self setBackgroundColor:[UIColor clearColor]];
    return self;
}


-(void) setUpCollectionViewFlowLayout{
    self.layout = [[CollectionLayout alloc]init];
    [self.layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.layout setMinimumInteritemSpacing:0.0f];
    [self.layout setMinimumLineSpacing:0.0f];
    [self setCollectionViewLayout:self.layout];
    [self setPagingEnabled:YES];
}

-(void)registerCellsForCollectionView{
    [self registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [self registerNib:[UINib nibWithNibName:@"BlankCell" bundle:nil] forCellWithReuseIdentifier:@"BlankCell"];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count+2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0||indexPath.row==self.dataArray.count+1){
        BlankCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BlankCell" forIndexPath:indexPath];
        return cell;
    }
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    cell.cellImage.image = [self.dataArray objectAtIndex:indexPath.row-1];
    cell.cellImage.clipsToBounds=YES;
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return CGSizeMake(40, self.frame.size.height);
    }
    return CGSizeMake(self.frame.size.width-80, self.frame.size.height-20);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    float pageWidth = 240; // width + space
    
    float currentOffset = scrollView.contentOffset.x;
    float targetOffset = targetContentOffset->x;
    float newTargetOffset = 0;
    
    if (targetOffset > currentOffset)
        newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth;
    else
        newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth;
    
    if (newTargetOffset < 0)
        newTargetOffset = 0;
    else if (newTargetOffset > scrollView.contentSize.width)
        newTargetOffset = scrollView.contentSize.width;
    
    targetContentOffset->x = currentOffset;
    [scrollView setContentOffset:CGPointMake(newTargetOffset, 0) animated:YES];
    
    int index = newTargetOffset / pageWidth;
    
    if (index == 0) { // If first index
        CollectionViewCell *cell =(CollectionViewCell *) [self cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index  inSection:0]];
        cell.transform = CGAffineTransformIdentity;
        cell = (CollectionViewCell *)[self cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index + 1  inSection:0]];
        //cell.transform = TRANSFORM_CELL_VALUE;

    }else{
        CollectionViewCell *cell =(CollectionViewCell *)[self cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        //cell.transform = CGAffineTransformIdentity;
        
        index --; // left
        cell =(CollectionViewCell *)[self cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
          //  cell.transform = TRANSFORM_CELL_VALUE;
        index ++;
        index ++; // right
        cell = (CollectionViewCell *)[self cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        //cell.transform = TRANSFORM_CELL_VALUE;
    }
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
