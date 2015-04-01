//This is a class for the detailed refer info view controller

#import <UIKit/UIKit.h>
#import "Refer.h"
#import "SavedReferDatabase.h"

@interface ReferDetailTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *referImageView;

@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *referReward;
- (IBAction)getReferredButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *otherInfoText;
@property (weak, nonatomic) IBOutlet UIButton *savedTheReferButton;

@property (strong,nonatomic) Refer *refer;

- (IBAction)SaveTheRefer:(id)sender;

@end
