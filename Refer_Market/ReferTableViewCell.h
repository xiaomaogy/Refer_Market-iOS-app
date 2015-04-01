//This is a customized table view cell for the referlistingtableviewcontroller

#import <UIKit/UIKit.h>
#import "Refer.h"

@interface ReferTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *referImage;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *otherInfo;

@end
