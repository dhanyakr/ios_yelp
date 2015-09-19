//
//  FilterValues.h
//  Yelp
//
//  Created by Dhanya R on 9/18/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterValues : NSObject
@property (nonatomic,strong) NSArray *sections;
@property (nonatomic,strong) NSArray *sectionTitles;
@property (nonatomic,strong) NSArray *categories;
@property (nonatomic,strong) NSArray *sortOptions;
@property (nonatomic,strong) NSArray *distanceOptions;
@property (nonatomic,strong) NSArray *deals;
@end
