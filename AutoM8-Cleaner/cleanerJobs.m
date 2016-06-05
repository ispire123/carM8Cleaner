//
//  cleanerJobs.m
//  AutoM8-Cleaner
//
//  Created by 1 on 22/03/2016.
//  Copyright © 2016 JoyTestapp. All rights reserved.
//

#import "cleanerJobs.h"
#import <Parse/Parse.h>
#import "cleanerjobTableViewCell.h"
#import "jobDetails.h"

@interface cleanerJobs ()

@end

@implementation cleanerJobs

@synthesize jobsTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    nameList = [[NSMutableArray alloc]init];
    phoneList = [[NSMutableArray alloc]init];
    
    //query to fetch all cleaning jobs
    PFQuery *query1 = [PFQuery queryWithClassName:@"cleaningService"];
    [query1 whereKey:@"status" equalTo:@"requested"];
    
    [query1 findObjectsInBackgroundWithBlock:^(NSArray *joblistfromParse, NSError *error) {
        if (!error){
            cleaningList = [[NSMutableArray alloc] initWithArray:joblistfromParse];
            NSLog(@"%@", joblistfromParse);
        }
        
        [jobsTable reloadData];  //update table when data is received
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return cleaningList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    cleanerjobTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jobCell" forIndexPath:indexPath];
    
    // Configure the cell...
    PFObject *parsecleaningobj = [cleaningList objectAtIndex:indexPath.row];
    
    cell.txtlocation.text = [parsecleaningobj objectForKey:@"location"];
    cell.txtlocation.font = [UIFont fontWithName:@"Arial" size:12];
    cell.txtdate.text = [parsecleaningobj objectForKey:@"date"];
    cell.txtdate.font = [UIFont fontWithName:@"Arial" size:12];
    cell.txttime.text = [parsecleaningobj objectForKey:@"time"];
    cell.txttime.font = [UIFont fontWithName:@"Arial" size:12];
    
    
    
    NSString *carid = [parsecleaningobj objectForKey:@"car"];
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"customerCars"];
    [query2 getObjectInBackgroundWithId:carid block:^(PFObject *carobject, NSError *carerror) {
        NSString *make = [carobject objectForKey:@"make"];
        NSString *model = [carobject objectForKey:@"model"];
        NSString *year = [carobject objectForKey:@"year"];
        
        NSArray *myStrings = [[NSArray alloc] initWithObjects:make, model, year, nil];
        NSString *joinedString = [myStrings componentsJoinedByString:@" "];
        
        cell.txtCar.text = joinedString;
        cell.txtCar.font = [UIFont fontWithName:@"Arial" size:14];
    }];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"detailofjob" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"detailofjob"]){
        
        NSIndexPath *indexPath = [self.jobsTable indexPathForCell:sender];
        
        jobDetails *cjD = [segue destinationViewController];
        
        PFObject *parsecleaningobj = [cleaningList objectAtIndex:indexPath.row];
        
        cjD.locationText = [parsecleaningobj objectForKey:@"location"];
        cjD.dateText = [parsecleaningobj objectForKey:@"date"];
        cjD.timeText= [parsecleaningobj objectForKey:@"time"];
        
        cjD.cleaningID = [parsecleaningobj objectId];
        
        NSString *customerid = [parsecleaningobj objectForKey:@"customer"];
        
        PFQuery *query1 = [PFUser query];
        [query1 getObjectInBackgroundWithId:customerid block:^(PFObject *customerobject, NSError *error) {
            if (error) {
                cjD.nameText = [customerobject objectForKey:@"fullName"];
                cjD.phoneText = [customerobject objectForKey:@"phone"];
            }
        }];
        
        NSString *carid = [parsecleaningobj objectForKey:@"car"];
        
        PFQuery *query2 = [PFQuery queryWithClassName:@"customerCars"];
        [query2 getObjectInBackgroundWithId:carid block:^(PFObject *carobject, NSError *carerror) {
            NSString *make = [carobject objectForKey:@"make"];
            NSString *model = [carobject objectForKey:@"model"];
            NSString *year = [carobject objectForKey:@"year"];
            
            NSArray *myStrings = [[NSArray alloc] initWithObjects:make, model, year, nil];
            NSString *joinedString = [myStrings componentsJoinedByString:@" "];
            
            cjD.carText = joinedString;
            
        }];
        

        
        
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
