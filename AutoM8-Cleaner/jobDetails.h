//
//  jobDetails.h
//  AutoM8-Cleaner
//
//  Created by 1 on 25/03/2016.
//  Copyright © 2016 JoyTestapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface jobDetails : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *txtName;
@property (strong, nonatomic) IBOutlet UILabel *txtphone;
@property (strong, nonatomic) IBOutlet UILabel *txtCar;
@property (strong, nonatomic) IBOutlet UILabel *txtDate;
@property (strong, nonatomic) IBOutlet UILabel *txtTime;
@property (strong, nonatomic) IBOutlet UILabel *txtLocation;


@property (strong, nonatomic)  NSString *locationText;
@property (strong, nonatomic)  NSString *dateText;
@property (strong, nonatomic)  NSString *timeText;
@property (strong, nonatomic)  NSString *carText;
@property (strong, nonatomic)  NSString *phoneText;
@property (strong, nonatomic)  NSString *nameText;

@property (strong, nonatomic) NSString *cleaningID;
- (IBAction)acceptJob:(id)sender;


@end
