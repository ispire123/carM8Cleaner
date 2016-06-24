//
//  dashboarddetails.m
//  AutoM8-Cleaner
//
//  Created by 1 on 22/03/2016.
//  Copyright © 2016 JoyTestapp. All rights reserved.
//

#import "dashboarddetails.h"
#import <Parse/Parse.h>
#import "cleaningjobTablecell.h"
#import "cleaningJobDetail.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface dashboarddetails ()

@end

@implementation dashboarddetails

@synthesize currentCleaningJobsTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    
   [currentCleaningJobsTable setDelegate:self];
   [currentCleaningJobsTable setDataSource:self];
    
    
    cleaningreqIDs = [[NSMutableArray alloc] init];
    carIDList = [[NSMutableArray alloc]init];
    locationList = [[NSMutableArray alloc]init];
    dateList = [[NSMutableArray alloc]init];
    timeList = [[NSMutableArray alloc]init];
    carList = [[NSMutableArray alloc]init];
    customerIDList = [[NSMutableArray alloc]init];
    nameList = [[NSMutableArray alloc]init];
    phoneList = [[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view.
    
    NSString *currentUser = [[PFUser currentUser] objectForKey:@"firstName"];
    NSLog(@"Name: %@", currentUser);
    _txtWelcome.text = [@"Hello " stringByAppendingString:currentUser];
    _txtWelcome.font = [UIFont fontWithName:@"Futura Medium" size:18.0];
    
    
    
    dispatch_group_t d_grp = dispatch_group_create();
    dispatch_queue_t bg_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_group_async(d_grp, bg_queue, ^{
        [self loadJobincell];
        [self cleaningdetailsfetcher];
        [self cardetailfecter];
        
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if ([currentCleaningJobsTable visibleCells]) {
                [currentCleaningJobsTable reloadData];
                NSUInteger count = [cleaningreqIDs count];
                
                NSString *inStrg = [NSString stringWithFormat: @"%ld", count];
                
                _jobList.text = [@"Current Jobs : " stringByAppendingString:inStrg];
            }
            
        });
        
        });
        
    
    
    
   
  //  currentCleaningJobsTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadJobincell{
    
    NSString *clearnerid = [PFUser currentUser].objectId;
    
    PFQuery *query1 = [PFQuery queryWithClassName:@"cleaningJobs"];
    [query1 whereKey:@"cleanerID" equalTo:clearnerid];
    [query1 whereKey:@"status" equalTo:[NSNumber numberWithBool:true]];
    
    NSArray *cleaningrequests = [query1 findObjects];
    
    for (PFObject *tempfromParse in cleaningrequests) {
        NSArray *cleanID = [tempfromParse objectForKey:@"cleaningID"];
        
        
        NSLog(@"Cleaning ID: %@", cleanID);
        if (cleanID == NULL){
            NSLog(@"no data to display");
            
        }
        else{
            [cleaningreqIDs addObject:cleanID];
            
        }
    }
}

-(void)cleaningdetailsfetcher{
    NSUInteger counter = cleaningreqIDs.count;
    
    for (NSUInteger index =0; index < counter ; index++){
        NSString *object = [cleaningreqIDs objectAtIndex:index];
        
        NSLog(@"object %@", object);
        
        PFQuery *query2 = [PFQuery queryWithClassName:@"cleaningService"];
        PFObject *tempfromParse = [query2 getObjectWithId:object];
        
        NSString *customerid = [tempfromParse objectForKey:@"customer"];
        if (customerid == NULL) {
            NSLog(@"no customer data");
        }
        else{
            [customerIDList addObject:customerid];
        }
        
        
        NSString *carid = [tempfromParse objectForKey:@"car"];
        if (carid == NULL) {
            NSLog(@"no data to display");
        }
        else{
        
        [carIDList addObject:carid];
        }
        
        
        NSString *txtlocation = [tempfromParse objectForKey:@"location"];
        if (txtlocation == NULL) {
            NSLog(@"no data to display");
        }
        else{
            [locationList addObject:txtlocation];
        }
        
        NSString *txtdate = [tempfromParse objectForKey:@"date"];
        if (txtdate == NULL) {
             NSLog(@"no data to display");
        }
        else{
            [dateList addObject:txtdate];
        }
        
        NSString *txttime = [tempfromParse objectForKey:@"time"];
        if (txttime == NULL) {
             NSLog(@"no data to display");
        }
        else{
            [timeList addObject:txttime];
        }
    }
}


-(void)cardetailfecter{
    NSUInteger counter2 = carIDList.count;
    
    for (NSUInteger index = 0; index < counter2; index++){
        NSString *carobject = [carIDList objectAtIndex:index];
        PFQuery *query3 = [PFQuery queryWithClassName:@"customerCars"];
        
        PFObject *tempfromParse = [query3 getObjectWithId:carobject];
        
        NSString *make = [tempfromParse objectForKey:@"make"];
        NSString *model = [tempfromParse objectForKey:@"model"];
        NSString *rego = [tempfromParse objectForKey:@"rego"];
        
        NSArray *myStrings = [[NSArray alloc] initWithObjects:make, model,rego,  nil];
        NSString *joinedString = [myStrings componentsJoinedByString:@" "];
        
        NSLog(@"joinedString: %@", joinedString);
        if (joinedString == NULL) {
            NSLog(@"No data to display");
        }
        else{
            [carList addObject:joinedString];
        }

    }
    
}

-(void)findcustomerDetails{
    NSUInteger counter4 = customerIDList.count;
    
    for (NSUInteger index=0; index <counter4; index++) {
        NSString *customerobject = [customerIDList objectAtIndex:index];
        
        PFQuery *query5 = [PFUser query];
        
        PFObject *tempfromParse = [query5 getObjectWithId:customerobject];
        
        NSString *name = [tempfromParse objectForKey:@"firstName"];
        NSString *phone = [tempfromParse objectForKey:@"phone"];
        
        [nameList addObject:name];
        [phoneList addObject:phone];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
 //   return 1;
   NSInteger numOfSections = 0;
    if ([carList count] != 0)
    {
        self.currentCleaningJobsTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        numOfSections                 = 1;
        currentCleaningJobsTable.backgroundView   = nil;
    }
    else
    {
        UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, currentCleaningJobsTable.bounds.size.width, currentCleaningJobsTable.bounds.size.height)];
        noDataLabel.text             = @"Pull to Refresh";
        noDataLabel.textColor        = [UIColor grayColor];
        noDataLabel.textAlignment    = NSTextAlignmentCenter;
        noDataLabel.font = [UIFont fontWithName:@"Futura Medium" size:18];
        currentCleaningJobsTable.backgroundView = noDataLabel;
        currentCleaningJobsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return numOfSections;
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return cleaningreqIDs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    cleaningjobTablecell *cell = [tableView dequeueReusableCellWithIdentifier:@"cjCell" forIndexPath:indexPath];
    
    NSLog(@"I am here");
    cell.txtlocation.text = [locationList objectAtIndex:indexPath.row];
    cell.txtlocation.font = [UIFont fontWithName:@"Futura" size:14.0];
    
    cell.txttime.text = [timeList objectAtIndex:indexPath.row];
    cell.txttime.font = [UIFont fontWithName:@"Futura" size:14.0];
    cell.txtdate.text = [dateList objectAtIndex:indexPath.row];
    cell.txtdate.font = [UIFont fontWithName:@"Futura" size:14.0];
    cell.txtcar.text = [carList objectAtIndex:indexPath.row];
    cell.txtcar.font = [UIFont fontWithName:@"Futura" size:18.0];
    
    cell.backgroundColor = [UIColor colorWithRed:1 green:.6 blue:.5 alpha:.5];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"cleaningJobDetail" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"cleaningJobDetail"]){
        
        NSIndexPath *jobindexPath = [self.currentCleaningJobsTable indexPathForCell:sender];
        
        cleaningJobDetail *cjD = [segue destinationViewController];
        
        
        dispatch_group_t d_grp = dispatch_group_create();
        dispatch_queue_t bg_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
        dispatch_group_async(d_grp, bg_queue, ^{
           
            [self findcustomerDetails];
            cjD.nameText = [nameList objectAtIndex:jobindexPath.row];
            cjD.phoneText = [phoneList objectAtIndex:jobindexPath.row];
        });
        
        
        
        
        //cjD.carText = [carList objectAtIndex:jobindexPath.row];
        cjD.dateText = [dateList objectAtIndex:jobindexPath.row];
        cjD.timeText = [timeList objectAtIndex:jobindexPath.row];
        cjD.locationText = [locationList objectAtIndex:jobindexPath.row];
        
       
        
        cjD.cleaningIDtxt = [cleaningreqIDs objectAtIndex:jobindexPath.row];
        
        
    }
}

@end
