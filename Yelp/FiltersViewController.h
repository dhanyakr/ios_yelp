//
//  FiltersViewController.h
//  Yelp
//
//  Created by Dhanya R on 9/17/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FiltersViewController;

@protocol FiltersViewControllerDelegate <NSObject>

- (void)filtersViewController:(FiltersViewController *)filtersViewController didChageFilters:(NSDictionary *)filters;

@end

@interface FiltersViewController : UIViewController

@property (nonatomic, weak) id<FiltersViewControllerDelegate> delegate;
@end
