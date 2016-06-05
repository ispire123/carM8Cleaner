//
//  cleanerLogin.h
//  AutoM8-Cleaner
//
//  Created by 1 on 22/03/2016.
//  Copyright © 2016 JoyTestapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cleanerLogin : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtcleaneremail;
@property (strong, nonatomic) IBOutlet UITextField *txtcleanerpassword;
- (IBAction)cleanersignin:(id)sender;

@end
