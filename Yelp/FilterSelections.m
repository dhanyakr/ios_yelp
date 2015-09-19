//
//  FilterSelections.m
//  Yelp
//
//  Created by Dhanya R on 9/19/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "FilterSelections.h"

@implementation FilterSelections
- (id)init {
    self = [super init];
    if(self){
        self.selectedCategories = [NSMutableSet set];
        self.selectedDeal = [NSMutableSet set];
        self.selectedSort = [NSString stringWithFormat:@""];
        self.selectedDistance = [NSString stringWithFormat:@""];
    }
    return self;
}

@end
