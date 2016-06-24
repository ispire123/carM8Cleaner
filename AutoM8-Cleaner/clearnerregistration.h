//
//  clearnerregistration.h
//  AutoM8-Cleaner
//
//  Created by 1 on 21/03/2016.
//  Copyright © 2016 JoyTestapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface clearnerregistration : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtFirstname;
@property (strong, nonatomic) IBOutlet UITextField *txtLastname;
@property (strong, nonatomic) IBOutlet UITextField *txtphone;
@property (strong, nonatomic) IBOutlet UITextField *txtemail;
@property (strong, nonatomic) IBOutlet UITextField *txtconfirmEmail;

@property (strong, nonatomic) IBOutlet UITextField *txtpassword;
@property (strong, nonatomic) IBOutlet UITextField *txtretypePassword;


@property (strong, nonatomic) IBOutlet UITextField *txtbusinessName;

@property (strong, nonatomic) IBOutlet UITextField *txtbusinessABN;


- (IBAction)registerCleaner:(id)sender;

@end
