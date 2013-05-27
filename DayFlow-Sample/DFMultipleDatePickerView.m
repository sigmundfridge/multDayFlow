//
//  DFMultipleDatePickerView.m
//  DayFlow-Sample
//
//  Created by Nick Jones on 25/05/2013.
//  Copyright (c) 2013 Radius. All rights reserved.
//

#import "DFMultipleDatePickerView.h"
#import <DFDatePickerDayCell.h>


@interface DFDatePickerView ()
@property (nonatomic, readonly, strong) NSCalendar *calendar;
@property (nonatomic, readonly, strong) UICollectionView *collectionView;
@property (nonatomic, readonly, strong) UICollectionViewFlowLayout *collectionViewLayout;
@property (nonatomic, strong) NSMutableArray *selectedDates;

- (NSDate *) dateForFirstDayInSection:(NSInteger)section;
- (NSDate *) dateFromPickerDate:(DFDatePickerDate)dateStruct;
- (NSDateComponents *) dateComponentsFromPickerDate:(DFDatePickerDate)dateStruct;
- (DFDatePickerDate) pickerDateFromDate:(NSDate *)date;

@end

static NSString * const DFDatePickerViewCellIdentifier = @"dateCell";

@implementation DFMultipleDatePickerView

@synthesize collectionView = _collectionView;
@synthesize selectedDates = _selectedDates;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(NSMutableArray*) selectedDates {
    if(!_selectedDates) {
        _selectedDates = [[NSMutableArray alloc]initWithArray:nil];
    }
    return _selectedDates;
}

- (UICollectionView *) collectionView {
    if(!_collectionView) {
        _collectionView = [super collectionView];
        _collectionView.allowsMultipleSelection = YES;
    }
    return _collectionView;
}

- (DFDatePickerDayCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	DFDatePickerDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DFDatePickerViewCellIdentifier forIndexPath:indexPath];
	
	NSDate *firstDayInMonth = [self dateForFirstDayInSection:indexPath.section];
	DFDatePickerDate firstDayPickerDate = [self pickerDateFromDate:firstDayInMonth];
	NSUInteger weekday = [self.calendar components:NSWeekdayCalendarUnit fromDate:firstDayInMonth].weekday;
	
	NSDate *cellDate = [self.calendar dateByAddingComponents:((^{
		NSDateComponents *dateComponents = [NSDateComponents new];
		dateComponents.day = indexPath.item - (weekday - 1);
		return dateComponents;
	})()) toDate:firstDayInMonth options:0];
	DFDatePickerDate cellPickerDate = [self pickerDateFromDate:cellDate];
	
	cell.date = cellPickerDate;
	cell.enabled = ((firstDayPickerDate.year == cellPickerDate.year) && (firstDayPickerDate.month == cellPickerDate.month));
	cell.selected = [self.selectedDates containsObject:cellDate];
	
	return cell;
	
}

-(void) collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath: (NSIndexPath *)indexPath {
	DFDatePickerDayCell *cell = ((DFDatePickerDayCell *)[collectionView cellForItemAtIndexPath:indexPath]);
    NSDate *date = [self.calendar dateFromComponents:[self dateComponentsFromPickerDate:cell.date]];
    [self.selectedDates removeObject:date];
    NSLog(@"Rem: %@", date);
    NSLog(@"ARRAy: %@", self.selectedDates);
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
	DFDatePickerDayCell *cell = ((DFDatePickerDayCell *)[collectionView cellForItemAtIndexPath:indexPath]);
    NSDate *date = [self.calendar dateFromComponents:[self dateComponentsFromPickerDate:cell.date]];
    [self.selectedDates addObject:date];
    NSLog(@"ADD: %@", self.selectedDates);
}

/*- (NSDateComponents *) dateComponentsFromPickerDate:(DFDatePickerDate)dateStruct {
	NSDateComponents *components = [NSDateComponents new];
	components.year = dateStruct.year;
	components.month = dateStruct.month;
	components.day = dateStruct.day;
	return components;
}*/




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
