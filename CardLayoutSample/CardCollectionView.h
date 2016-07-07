//
//  CardCollectionView.h
//  CardLayoutSample
//
//  Created by Sanchit Kumar Singh on 6/30/16.
//  Copyright © 2016 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionLayout.h"

@interface CardCollectionView : UICollectionView <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
-(id)initWithFrame:(CGRect)frame data:(NSArray *)dataArray;
@property (strong,nonatomic) CollectionLayout *layout;
@end
