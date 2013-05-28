#import "DFSAppDelegate.h"
#import <DayFlow/DFDatePickerView.h>
#import <DayFlow/DFDatePickerViewController.h>
#import "DFDatePickerMultipleViewController.h"

@interface DFSAppDelegate () <DFDatePickerViewControllerDelegate>
@end

@implementation DFSAppDelegate

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//	DFDatePickerMultipleViewController *picker = [DFDatePickerMultipleViewController new];
//	picker.delegate = self;
//	self.window.rootViewController = picker;
//	[self.window makeKeyAndVisible];
	return YES;
}

- (void) datePickerViewController:(DFDatePickerMultipleViewController *)controller didSelectDate:(NSDate *)date {

	//[[[UIAlertView alloc] initWithTitle:@"Picked Date" message:[date description] delegate:nil cancelButtonTitle:@":D" otherButtonTitles:nil] show];
	NSLog(@"Date: %@", controller.datePickerView.selectedDate );
	//	If you set it to something not nil, we’ll call you again
	//	so don’t.
	
	//controller.datePickerView.selectedDate = nil;

}

@end
