//
//  SegmentCell.m
//  Yelp
//
//  Created by Dhanya R on 9/18/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "SegmentCell.h"
@interface SegmentCell ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentSelection;

@end
@implementation SegmentCell
- (IBAction)segmentSelection:(id)sender {
    [self.delegate segmentCell:self didUpdateValue:self.segmentSelection.selected];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
