//
//  DFDatePickerMultipleViewController.m
//  DayFlow-Sample
//
//  Created by Nick Jones on 25/05/2013.
//  Copyright (c) 2013 Radius. All rights reserved.
//

#import "DFDatePickerMultipleViewController.h"

@interface DFDatePickerMultipleViewController (){
    NSIndexPath *lastAccessed;
}
@end

@implementation DFDatePickerMultipleViewController
@synthesize datePickerView = _datePickerView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(DFMultipleDatePickerView*) datePickerView {
    if (!_datePickerView) {
        _datePickerView = [DFMultipleDatePickerView new];
        _datePickerView.frame = self.view.bounds;
        _datePickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _datePickerView;
}

- (void) handleGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    float pointerX = [gestureRecognizer locationInView:self.datePickerView.collectionView].x;
    float pointerY = [gestureRecognizer locationInView:self.datePickerView.collectionView].y;
    
    for (UICollectionViewCell *cell in self.datePickerView.collectionView.visibleCells) {
        float cellSX = cell.frame.origin.x;
        float cellEX = cell.frame.origin.x + cell.frame.size.width;
        float cellSY = cell.frame.origin.y;
        float cellEY = cell.frame.origin.y + cell.frame.size.height;
        
        if (pointerX >= cellSX && pointerX <= cellEX && pointerY >= cellSY && pointerY <= cellEY)
        {
            NSIndexPath *touchOver = [self.datePickerView.collectionView indexPathForCell:cell];
            
            if (lastAccessed != touchOver)
            {
                if (cell.selected)
                    [self deselectCellForCollectionView:self.datePickerView.collectionView atIndexPath:touchOver];
                else
                    [self selectCellForCollectionView:self.datePickerView.collectionView atIndexPath:touchOver];
            }
            
            lastAccessed = touchOver;
        }
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        lastAccessed = nil;
        self.datePickerView.collectionView.scrollEnabled = YES;
        [self.datePickerView.collectionView reloadData];
    }
}

- (void) selectCellForCollectionView:(UICollectionView *)collection atIndexPath:(NSIndexPath *)indexPath
{
    [collection selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    [self.datePickerView collectionView:collection didSelectItemAtIndexPath:indexPath];
}

- (void) deselectCellForCollectionView:(UICollectionView *)collection atIndexPath:(NSIndexPath *)indexPath
{
    [collection deselectItemAtIndexPath:indexPath animated:YES];
    [self.datePickerView collectionView:collection didDeselectItemAtIndexPath:indexPath];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    //[self.view addGestureRecognizer:gestureRecognizer];
    [gestureRecognizer setMinimumNumberOfTouches:1];
    [gestureRecognizer setMaximumNumberOfTouches:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
