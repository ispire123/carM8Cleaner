//
//  cleaningJobDetail.m
//  AutoM8-Cleaner
//
//  Created by 1 on 25/03/2016.
//  Copyright © 2016 JoyTestapp. All rights reserved.
//

#import "cleaningJobDetail.h"
#import <Parse/Parse.h>

@interface cleaningJobDetail ()

@end

@implementation cleaningJobDetail
@synthesize cleaningIDtxt;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.txtName.text = self.nameText;
    self.txtphone.text = self.phoneText;
    self.txtCar.text = self.carText;
    self.txtDate.text = self.dateText;
    self.txtTime.text = self.timeText;
    self.txtLocation.text = self.locationText;
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


- (IBAction)completeJob:(id)sender {
    
    
  //  UIAlertController *completejob = [UIAlertController alertControllerWithTitle:@"Job Complete" message:@"Are you sure?" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertController *completejob = [UIAlertController alertControllerWithTitle:@"Complete"
                                                                         message:@"Do you want to mark the Job as Complete?"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction* yes = [UIAlertAction actionWithTitle:@"Yes"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              PFQuery *query = [PFQuery queryWithClassName:@"cleaningJobs"];
                              [query whereKey:@"cleaningID" equalTo:cleaningIDtxt];
                              
                              NSArray *cleaning = [query findObjects];
                              for(PFObject *temp in cleaning){
                                  temp[@"status"] = [NSNumber numberWithBool:false];
                                  [temp saveInBackground];
                              }
                              
                              
                              [completejob dismissViewControllerAnimated:YES completion:nil];
                              
                              
                              UIStoryboard *dashboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                              
                              UITabBarController *cleaner = [dashboard instantiateViewControllerWithIdentifier:@"cleanerDashboard"];
                               [self presentViewController:cleaner animated:YES completion:nil];
                          }];
    
    UIAlertAction* no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [completejob dismissViewControllerAnimated:YES completion:nil];
    } ];
    
    [completejob addAction:yes];
    [completejob addAction:no];
    
    
    [self presentViewController:completejob animated:YES completion:nil];
    
   // [tableView reloadData];

    

    
    
    
    
}
@end
