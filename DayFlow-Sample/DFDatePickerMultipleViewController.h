//
//  DFDatePickerMultipleViewController.h
//  DayFlow-Sample
//
//  Created by Nick Jones on 25/05/2013.
//  Copyright (c) 2013 Radius. All rights reserved.
//

#import "DFDatePickerViewController.h"
#import "DFMultipleDatePickerView.h"

@interface DFDatePickerMultipleViewController : DFDatePickerViewController

@property (nonatomic, readonly, strong) DFMultipleDatePickerView *datePickerView;
@property (nonatomic, readwrite, weak) id<DFDatePickerViewControllerDelegate> delegate;

@end
