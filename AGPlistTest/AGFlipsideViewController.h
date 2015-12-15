//
//  AGTableViewController.h
//  AGPlistTest
//
//  Created by AG on 12/11/15.
//  Copyright © 2015 AG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AGFlipsideViewController;

@protocol AGFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(AGFlipsideViewController *)controller;
@end

@interface AGFlipsideViewController : UIViewController

@property (weak, nonatomic) id <AGFlipsideViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISwitch *autoUpdateSwitch;
@property (weak, nonatomic) IBOutlet UISlider *timeCookSlider;

- (void)refreshFields;
- (IBAction)engineSwitchTapped;
- (IBAction)warpSliderTouched;
- (IBAction)done:(id)sender;

@end
