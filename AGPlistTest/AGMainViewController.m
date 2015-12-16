//
//  AGTableViewController.h
//  AGPlistTest
//
//  Created by AG on 12/11/15.
//  Copyright © 2015 AG. All rights reserved.
//

#import "AGMainViewController.h"

@interface AGMainViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorizationCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *autoUpdateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeCookLabel;
@property (weak, nonatomic) IBOutlet UILabel *serverUrl;
@property (weak, nonatomic) IBOutlet UILabel *serverPortName;


@end

@implementation AGMainViewController

- (void)refreshFields {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.userLabel.text = [defaults objectForKey:kUserKey];
    self.authorizationCodeLabel.text = [defaults
                                        objectForKey:kAuthorizationCodeKey];
    self.rankLabel.text = [defaults objectForKey:kRankKey];
    self.autoUpdateLabel.text = [defaults boolForKey:kAutoUpdateKey]
                                ? @"YES" : @"Disabled";
    self.timeCookLabel.text = [[defaults objectForKey:kTimeCookKey]
                                 stringValue];
    self.serverUrl.text = [defaults objectForKey:kServerURLKey];
    self.serverPortName.text = [defaults objectForKey:kServerPortNumberKey];
    }

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshFields];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:app];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:(BOOL)animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(AGFlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

- (void)applicationWillEnterForeground:(NSNotification *)notification {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    [self refreshFields];
}


@end
