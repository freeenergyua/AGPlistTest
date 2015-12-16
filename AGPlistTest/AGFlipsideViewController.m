//
//  AGTableViewController.h
//  AGPlistTest
//
//  Created by AG on 12/11/15.
//  Copyright © 2015 AG. All rights reserved.
//

#import "AGFlipsideViewController.h"
#import "AGMainViewController.h"

@interface AGFlipsideViewController ()

@end

@implementation AGFlipsideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self onDefaultsChanged:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self onDefaultsChanged:nil];
    
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:app];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDefaultsChanged:)
                                                 name:NSUserDefaultsDidChangeNotification
                                               object:nil];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:(BOOL)animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSUserDefaultsDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (IBAction)engineSwitchTapped {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.autoUpdateSwitch.on forKey:kAutoUpdateKey];
    NSLog(@"autoUpdateSwitch %d",[defaults boolForKey:kAutoUpdateKey]);
    [defaults synchronize];
}

- (IBAction)warpSliderTouched {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:self.timeCookSlider.value forKey:kTimeCookKey];
    NSLog(@"kTimeCookKey %d",[defaults boolForKey:kTimeCookKey]);
    [defaults synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (void)applicationWillEnterForeground:(NSNotification *)notification {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
}
- (IBAction)openApplicationSettings:(id)sender {
   
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

- (void)onDefaultsChanged:(NSNotification*)aNotification {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.autoUpdateSwitch.on =  [defaults boolForKey:kAutoUpdateKey];
    self.timeCookSlider.value = [defaults integerForKey:kTimeCookKey];
    [defaults synchronize];
}



@end
