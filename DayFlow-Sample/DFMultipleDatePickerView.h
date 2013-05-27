//
//  DFMultipleDatePickerView.h
//  DayFlow-Sample
//
//  Created by Nick Jones on 25/05/2013.
//  Copyright (c) 2013 Radius. All rights reserved.
//

#import "DFDatePickerView.h"

@interface DFMultipleDatePickerView : DFDatePickerView
@property (nonatomic, readonly, strong) UICollectionView *collectionView;
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
-(void) collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath: (NSIndexPath *)indexPath;
@end
