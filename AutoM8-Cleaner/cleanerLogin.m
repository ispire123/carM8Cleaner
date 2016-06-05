//
//  cleanerLogin.m
//  AutoM8-Cleaner
//
//  Created by 1 on 22/03/2016.
//  Copyright © 2016 JoyTestapp. All rights reserved.
//

#import "cleanerLogin.h"
#import <Parse/Parse.h>

@interface cleanerLogin ()

@end

@implementation cleanerLogin

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)cleanersignin:(id)sender {
    [self letUserLogin];
}


//Checks if email and password filed is empty

-(void) checkfields{
    if ([_txtcleaneremail.text isEqualToString:@""] || [_txtcleanerpassword.text isEqualToString:@""]==true) {
        UIAlertController *fieldAreEmpty = [UIAlertController alertControllerWithTitle:@"Missing Field" message:@"Please Enter All the fields" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [fieldAreEmpty dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [fieldAreEmpty addAction:ok];
        [self presentViewController:fieldAreEmpty animated:YES completion:nil];
    }
    else{
        [self checkEmail];
    }
}

//cheaks if email field is empty
-(void) checkEmail{
    if ([_txtcleaneremail.text isEqualToString:@""]) {
        UIAlertController *fieldAreEmpty = [UIAlertController alertControllerWithTitle:@"Missing Field" message:@"Please Enter Email" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [fieldAreEmpty dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [fieldAreEmpty addAction:ok];
        [self presentViewController:fieldAreEmpty animated:YES completion:nil];
    }
    else{
        [self checkPassword];
    }
}


//Checks if password field is empty

-(void) checkPassword{
    if ([_txtcleanerpassword.text isEqualToString:@""]) {
        UIAlertController *fieldAreEmpty = [UIAlertController alertControllerWithTitle:@"Missing Field" message:@"Please Enter Password" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [fieldAreEmpty dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [fieldAreEmpty addAction:ok];
        [self presentViewController:fieldAreEmpty animated:YES completion:nil];
    }
    else{
        [self letUserLogin];
    }
}

//if the authenication is successful, lets the user into the Dashboard

-(void) letUserLogin{
    [PFUser logInWithUsernameInBackground:_txtcleaneremail.text password:_txtcleanerpassword.text block:^(PFUser *user, NSError *error){
        if (error == false) {
            UIStoryboard *dashboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            UITabBarController *tabView = [dashboard instantiateViewControllerWithIdentifier:@"cleanerDashboard"];
            
            [self presentViewController:tabView animated:YES completion:nil];
        }
        else if(error){
            UIAlertController *fieldAreEmpty = [UIAlertController alertControllerWithTitle:@"LogIn Failed" message:@"Please use the correct Username/Password" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [fieldAreEmpty dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            
            
            [fieldAreEmpty addAction:ok];
            [self presentViewController:fieldAreEmpty animated:YES completion:nil];
        }
        else
        {
            UIAlertController *fieldAreEmpty = [UIAlertController alertControllerWithTitle:@"Try Again" message:@"We Found Some Technical Error" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [fieldAreEmpty dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            
            
            [fieldAreEmpty addAction:ok];
            [self presentViewController:fieldAreEmpty animated:YES completion:nil];
        }
    }];
}
@end
