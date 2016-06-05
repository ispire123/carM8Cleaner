//
//  dashboarddetails.h
//  AutoM8-Cleaner
//
//  Created by 1 on 22/03/2016.
//  Copyright © 2016 JoyTestapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dashboarddetails : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *cleaningreqIDs;
    NSMutableArray *carIDList;
    NSMutableArray *locationList;
    NSMutableArray *dateList;
    NSMutableArray *timeList;
    NSMutableArray *customerIDList;
    NSMutableArray *carList;
    NSMutableArray *nameList;
    NSMutableArray *phoneList;
    UIActivityIndicatorView *ac;
}
@property (strong, nonatomic) IBOutlet UILabel *jobList;
@property (strong, nonatomic) IBOutlet UILabel *txtWelcome;
@property (strong, nonatomic) IBOutlet UITableView *currentCleaningJobsTable;
@property (strong, nonatomic) IBOutlet UILabel *txtnoofjobs;
@property(nonatomic, readwrite, retain) UIView *backgroundView;
//- (IBAction)addCleaningjobs:(id)sender;

@end
