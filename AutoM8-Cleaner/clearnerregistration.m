//
//  clearnerregistration.m
//  AutoM8-Cleaner
//
//  Created by 1 on 21/03/2016.
//  Copyright © 2016 JoyTestapp. All rights reserved.
//

#import "clearnerregistration.h"
#import <Parse/Parse.h>

@interface clearnerregistration ()

@end

@implementation clearnerregistration

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) regCleaner{
    
    
    PFUser *regClean = [PFUser user];
    
    regClean.username = _txtemail.text;
    regClean.password = _txtpassword.text;
    regClean.email = _txtemail.text;
    regClean[@"userType"] = @"cleaner";
    regClean[@"firstName"] = _txtFirstname.text;
    regClean[@"lastName"] = _txtLastname.text;
    regClean[@"phone"] = _txtphone.text;
    
    [regClean signUpInBackgroundWithBlock:^(BOOL success, NSError *error){
        if (!error) {
            [self cleanerDetails];
            UIAlertController *registrationError = [UIAlertController alertControllerWithTitle:@"SignUp success" message:@"Registration completed successfully" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Login" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                [registrationError dismissViewControllerAnimated:YES completion:nil];
                
                UIStoryboard *dashboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                
                UITabBarController *cleaner = [dashboard instantiateViewControllerWithIdentifier:@"cleanerDashboard"];
               
                [self presentViewController:cleaner animated:YES completion:nil];

            }];
            [registrationError addAction:ok];
            [self presentViewController:registrationError animated:YES completion:nil];
            
        }
        else{
            UIAlertController *registrationError = [UIAlertController alertControllerWithTitle:@"Registrastion Failed" message:@"The Email Might be Already Taken" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                [registrationError dismissViewControllerAnimated:YES completion:nil];
            }];
            [registrationError addAction:ok];
            [self presentViewController:registrationError animated:YES completion:nil];
        }
        
    }];
    
}

-(void) cleanerDetails{
    
    PFObject *cleanerMaster = [PFObject objectWithClassName:@"cleaner"]; //object for the class "cleaner" is created
    
    cleanerMaster[@"firstName"] = _txtFirstname.text;
    cleanerMaster[@"lastName"] = _txtLastname.text;
    cleanerMaster[@"email"] = _txtemail.text;
    cleanerMaster[@"ABN"] = _txtbusinessABN.text;
    cleanerMaster[@"businessName"] = _txtbusinessName.text;
    
    [cleanerMaster saveInBackground]; //insert clearner details in cleaner table
}



- (IBAction)registerCleaner:(id)sender {
    [self regCleaner];
    
}
@end
