//
//  Refer.m
//  testproject
//
//  Created by yuan gao on 3/3/15.
//  Copyright (c) 2015 yuan gao. All rights reserved.
//

#import "Refer.h"

@implementation Refer




//This method is used to load the Referdatabase's array info into each refer listing
+ (id)initWithUniqueId:(int)uniqueId companyName:(NSString *)companyName reward:(NSString*)referReward
             otherInfo:(NSString*)otherInfo referLink:(NSString*)referLink referImage:(NSData*)referImage
{
    Refer *newRefer=[[self alloc] init];
    
    
    newRefer.uniqueId = uniqueId;
    newRefer.companyName=companyName;
    newRefer.referReward=referReward;
    newRefer.otherInfo=otherInfo;
    newRefer.referLink=referLink;
    newRefer.referImage=referImage;
    
    return newRefer;
}


@end
