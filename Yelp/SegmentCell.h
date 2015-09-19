//
//  SegmentCell.h
//  Yelp
//
//  Created by Dhanya R on 9/18/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SegmentCell;
@protocol SegmentCellDelegate <NSObject>

-(void)segmentCell:(SegmentCell *)cell didUpdateValue:(BOOL)value;

@end


@interface SegmentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentSelect;
@property (nonatomic,assign) BOOL userSelection;
@property(nonatomic,weak) id<SegmentCellDelegate> delegate;
@end
