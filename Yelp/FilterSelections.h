//
//  FilterSelections.h
//  Yelp
//
//  Created by Dhanya R on 9/19/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterSelections : NSObject
@property (nonatomic, strong) NSMutableSet *selectedCategories;
@property (nonatomic, strong) NSMutableSet *selectedDeal;
@property (nonatomic, strong) NSString *selectedSort;
@property (nonatomic, strong) NSString *selectedDistance;

@end
