//This is a class for storing the custom refer items

#import <Foundation/Foundation.h>

@interface Refer : NSObject {
    NSString *category;
    NSString *name;
}

@property (nonatomic, assign) int uniqueId;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *referReward;
@property (nonatomic,copy) NSString *otherInfo;
@property (nonatomic,copy) NSString *referLink;
@property (nonatomic,copy) NSData * referImage;


+ (id)initWithUniqueId:(int)uniqueId companyName:(NSString *)companyName reward:(NSString*)referReward
             otherInfo:(NSString*)otherInfo referLink:(NSString*)referLink referImage:(NSData*)referImage;

@end
