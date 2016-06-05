//
//  cleanerJobs.h
//  AutoM8-Cleaner
//
//  Created by 1 on 22/03/2016.
//  Copyright © 2016 JoyTestapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cleanerJobs : UITableViewController{
    NSMutableArray *cleaningList;
    NSMutableArray *nameList;
    NSMutableArray *phoneList;
}
@property (strong, nonatomic) IBOutlet UITableView *jobsTable;

@end
