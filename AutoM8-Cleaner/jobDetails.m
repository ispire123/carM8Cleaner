//
//  jobDetails.m
//  AutoM8-Cleaner
//
//  Created by 1 on 25/03/2016.
//  Copyright © 2016 JoyTestapp. All rights reserved.
//

#import "jobDetails.h"
#import <Parse/Parse.h>

@interface jobDetails ()

@end

@implementation jobDetails
@synthesize cleaningID;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.txtName.text = self.nameText;
    self.txtphone.text = self.phoneText;
    self.txtCar.text = self.carText;
    self.txtDate.text = self.dateText;
    self.txtTime.text = self.timeText;
    self.txtLocation.text = self.locationText;

    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)acceptJob:(id)sender {
    PFObject *tempforParse = [PFObject objectWithClassName:@"cleaningJobs"];
    NSString *cleaner = [PFUser currentUser].objectId;
    
    tempforParse[@"cleanerID"] = cleaner;
    tempforParse[@"cleaningID"] = cleaningID;
    tempforParse[@"status"] = [NSNumber numberWithBool:true];
    
    [tempforParse saveInBackground];
    
    PFQuery *query = [PFQuery queryWithClassName:@"cleaningService"];
    
    [query getObjectInBackgroundWithId:cleaningID block:^(PFObject *cleanobject, NSError *error) {
        if (!error) {
            cleanobject[@"status"] = [NSNumber numberWithBool:true];
            [cleanobject saveInBackground];
        }
    }];
    
    UIAlertController *acceptJob = [UIAlertController alertControllerWithTitle:@"Added!" message:@"Job added to your account" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIStoryboard *joblist = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITabBarController *change = [joblist instantiateViewControllerWithIdentifier:@"cleanerDashboard"];
        
        [self presentViewController:change animated:YES completion:nil];
    }];
    
    [acceptJob addAction:ok];
    [self presentViewController:acceptJob animated:YES completion:nil];
    
    
}
@end
