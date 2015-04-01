//
//  SavedReferTableViewController.m
//  testproject
//
//  Created by yuan gao on 3/15/15.
//  Copyright (c) 2015 yuan gao. All rights reserved.
//

#import "SavedReferTableViewController.h"

@implementation SavedReferTableViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSArray *referDatabaseArray=[SavedReferDatabase database].ReferInfos;
    self.referArray=[NSMutableArray arrayWithArray:referDatabaseArray];
    self.tableView.rowHeight=100.0;
    
    // Reload the table
    [self.tableView reloadData];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"getting the click");
//
//}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.referArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //static NSString* CellIdentifier=@"referTableCell";
    ReferTableViewCell *referCell = [self.tableView dequeueReusableCellWithIdentifier:@"referTableCell" ];
    if(referCell==nil){
        referCell=[[ReferTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"referTableCell"];
    }
    
    Refer *refer=nil;
    
    
    refer=[self.referArray objectAtIndex:indexPath.row];
    
    
    
    
    referCell.companyName.text=refer.companyName;
    referCell.otherInfo.text=refer.otherInfo;
    
    UIImage *referImage=[UIImage imageWithData:refer.referImage];
    
    UIImageView *referImageView=[[UIImageView alloc]initWithImage:referImage];
    referImageView.frame=CGRectMake(10, 10, 80, 80);
    
    referImageView.contentMode=UIViewContentModeScaleToFill;
    
    [referCell.referImage addSubview:referImageView];
   
    return referCell;
}









 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
     return YES;
 }


 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
     Refer *referDeleted=[self.referArray objectAtIndex:indexPath.row];
     int uniqueIdDeleted=referDeleted.uniqueId;
     [[SavedReferDatabase database] deleteData:uniqueIdDeleted];
     [self.referArray removeObjectAtIndex:indexPath.row];
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 

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


#pragma mark - Segue


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([[segue identifier] isEqualToString:@"showReferDetailSegue2"]) {
        ReferDetailTableViewController *referDetailViewController = [segue destinationViewController];
        // In order to manipulate the destination view controller, another check on which table (search or normal) is displayed is needed
        
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            Refer *selectedRefer = [self.referArray objectAtIndex:indexPath.row];
            NSLog(@"refer:%@",selectedRefer);
            referDetailViewController.refer=selectedRefer;
        
        
    }
}


@end

