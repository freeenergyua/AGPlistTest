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
    [self refreshFields];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshFields];
    [self loadPersistentData:self];
    
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:app];
    
}
- (void) awakeFromNib {
    [self refreshFields];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDefaultsChanged:)
                                                 name:NSUserDefaultsDidChangeNotification
                                               object:nil];
}

//1
- (void)savePersistentData:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:self.autoUpdateSwitch.on forKey:kAutoUpdateKey];
    [userDefaults setFloat:self.timeCookSlider.value forKey:kTimeCookKey];
    //Save Changes
    [userDefaults synchronize];
}
//1
- (void)loadPersistentData:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.timeCookSlider.value = [userDefaults floatForKey:kAutoUpdateKey];
    self.autoUpdateSwitch.on  = [userDefaults boolForKey:kAutoUpdateKey];
    [userDefaults synchronize];

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:(BOOL)animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSUserDefaultsDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)refreshFields {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.autoUpdateSwitch.on  = [defaults boolForKey:kAutoUpdateKey];
    self.timeCookSlider.value = [defaults floatForKey:kAutoUpdateKey];
    [defaults synchronize];
}


- (IBAction)engineSwitchTapped {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.autoUpdateSwitch.on forKey:kAutoUpdateKey];
    [self onDefaultsChanged:nil];
    NSLog(@"autoUpdateSwitch %d",[defaults boolForKey:kAutoUpdateKey]);
    [defaults synchronize];
   
}

- (IBAction)warpSliderTouched {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:self.timeCookSlider.value forKey:kTimeCookKey];
    [self onDefaultsChanged:nil];
    NSLog(@"kTimeCookKey %f",[defaults floatForKey:kTimeCookKey]);
    
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
