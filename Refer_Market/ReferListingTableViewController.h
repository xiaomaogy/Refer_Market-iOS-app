//This is a class for the listing of all the refer information

#import <UIKit/UIKit.h>
#import "Refer.h"
#import "ReferTableViewCell.h"
#import <sqlite3.h>
#import "ReferDatabase.h"
#import "ReferDetailTableViewController.h"

@interface ReferListingTableViewController : UITableViewController<UISearchBarDelegate,UISearchDisplayDelegate>

@property (strong,nonatomic) NSArray *referArray;
@property (strong,nonatomic) NSMutableArray *filteredReferArray;
@property (weak, nonatomic) IBOutlet UISearchBar *referSearchBar;

@property (strong,nonatomic) UIViewController *vc;

@end
