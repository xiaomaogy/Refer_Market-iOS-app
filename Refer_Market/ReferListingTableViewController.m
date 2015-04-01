//
//  ReferListingTableViewController.m
//  testproject
//
//  Created by yuan gao on 3/3/15.
//  Copyright (c) 2015 yuan gao. All rights reserved.
//

#import "ReferListingTableViewController.h"

@interface ReferListingTableViewController ()

@end

@implementation ReferListingTableViewController


-(void)refreshFields{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    //BOOL soundBOOL=[defaults boolForKey:@"play_sounds_preference"];
    //NSDate *initialDate=[defaults objectForKey:@"Initial_Launch"];
    //NSLog(@"the current date is:%@",initialDate);
    //NSLog(@"play sound option:%d",soundBOOL );
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    [self setNeedsStatusBarAppearanceUpdate];
    //[self showSplashView];
    [self refreshFields];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    NSArray *referDatabaseArray=[ReferDatabase database].ReferInfos;
    self.referArray=[NSArray arrayWithArray:referDatabaseArray];
    self.filteredReferArray=[[NSMutableArray alloc]initWithCapacity:self.referArray.count];
    
    self.searchDisplayController.searchResultsTableView.rowHeight=self.tableView.rowHeight;

    // Reload the table
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshFields) name:NSUserDefaultsDidChangeNotification object:nil];
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
    if(tableView==self.searchDisplayController.searchResultsTableView){
        return self.filteredReferArray.count;
    }else{
        return self.referArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //static NSString* CellIdentifier=@"referTableCell";
    ReferTableViewCell *referCell = [self.tableView dequeueReusableCellWithIdentifier:@"referTableCell" ];
    if(referCell==nil){
        referCell=[[ReferTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"referTableCell"];
    }
    
    Refer *refer=nil;
    
    if(tableView==self.searchDisplayController.searchResultsTableView){
        refer=[self.filteredReferArray objectAtIndex:indexPath.row];
    }else{
        refer=[self.referArray objectAtIndex:indexPath.row];
    }
    
    
    
    referCell.companyName.text=refer.companyName;
    referCell.otherInfo.text=refer.otherInfo;
    
    UIImage *referImage=[UIImage imageWithData:refer.referImage];
    
    UIImageView *referImageView=[[UIImageView alloc]initWithImage:referImage];
    referImageView.frame=CGRectMake(10, 10, 80, 80);
    
    referImageView.contentMode=UIViewContentModeScaleToFill;
    
    [referCell.referImage addSubview:referImageView];
    
    
    
    
    
    return referCell;
}

#pragma mark- search text

-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredReferArray removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.companyName contains[c] %@",searchText];
    self.filteredReferArray = [NSMutableArray arrayWithArray:[self.referArray filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
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


#pragma mark - Segue


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([[segue identifier] isEqualToString:@"showReferDetailSegue"]) {
        ReferDetailTableViewController *referDetailViewController = [segue destinationViewController];
        // In order to manipulate the destination view controller, another check on which table (search or normal) is displayed is needed
        if(sender == self.searchDisplayController.searchResultsTableView) {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForCell:sender];
            Refer *selectedRefer = [self.filteredReferArray objectAtIndex:indexPath.row];
            NSLog(@"refer:%@",selectedRefer);
            referDetailViewController.refer=selectedRefer;
        }
        else {
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            Refer *selectedRefer = [self.referArray objectAtIndex:indexPath.row];
            NSLog(@"refer:%@",selectedRefer);
            referDetailViewController.refer=selectedRefer;
        }
        
    }
}



@end
