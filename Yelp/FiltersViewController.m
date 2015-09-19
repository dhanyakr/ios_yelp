//
//  FiltersViewController.m
//  Yelp
//
//  Created by Dhanya R on 9/17/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "FiltersViewController.h"
#import "SwitchCell.h"
#import "SegmentCell.h"
#import "FilterValues.h"
#import "FilterSelections.h"

@interface FiltersViewController () <UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate, SegmentCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,readonly) NSDictionary *filters;
@property (nonatomic,strong) FilterValues *filterValues;
@property (nonatomic,strong) FilterSelections *filterSelections;
/*
@property (nonatomic, strong) NSMutableSet *selectedCategories;
@property (nonatomic, strong) NSMutableSet *selectedDeal;
@property (nonatomic, strong) NSString *selectedSort;
@property (nonatomic, strong) NSString *selectedDistance;
*/


@end

@implementation FiltersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        /*
        self.selectedCategories = [NSMutableSet set];
        self.selectedDeal = [NSMutableSet set];
        self.selectedSort = [NSString stringWithFormat:@""];
        self.selectedDistance = [NSString stringWithFormat:@""];
         */
        self.filterValues = [[FilterValues alloc] init];
        self.filterSelections = [[FilterSelections alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:self action:@selector(onApplyButton)];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.title = @"Filters";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SwitchCell" bundle:nil] forCellReuseIdentifier:@"SwitchCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SegmentCell" bundle:nil] forCellReuseIdentifier:@"SegmentCell"];
    
    self.navigationController.navigationBar.barTintColor =  [UIColor redColor];
    self.navigationController.navigationBar.tintColor =  [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view methods;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.filterValues.sections count];
}
/*
- (NSInteger)tableView:(UITableView *)tableView numberOfSectionsInTableView:(NSInteger)section {
    NSLog(@"sections count: %lu", self.sections.count);
    //return self.sections.count;
    return 4;
}*/

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   return 55.0;
}
/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSLog(@"section : %lu", section);
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, 250, 15)];
    
    [centerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    centerView.backgroundColor = [UIColor redColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 250, 15)];
    label.text = @"test";
    
    [centerView addSubview:label];
    
    return centerView;
}
*/
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.filterValues.sections objectAtIndex:section];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    if (section == 0) {
        return self.filterValues.deals.count;
    } else if (section == 3) {
        return self.filterValues.categories.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
        cell.titleLabel.text = self.filterValues.deals[indexPath.row][@"name"];
        cell.on = [self.filterSelections.selectedDeal containsObject:self.filterValues.deals[indexPath.row]];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 1) {
        SegmentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SegmentCell"];
        [cell.segmentSelect removeAllSegments];
        for (NSString *distanceOption in self.filterValues.distanceOptions) {
            [cell.segmentSelect insertSegmentWithTitle:distanceOption atIndex:cell.segmentSelect.numberOfSegments animated:NO];
        }
        cell.delegate = self;
        return cell;
        
    } else if (indexPath.section == 2) {
        SegmentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SegmentCell"];
        [cell.segmentSelect removeAllSegments];
        for (NSString *sortOption in self.filterValues.sortOptions) {
            [cell.segmentSelect insertSegmentWithTitle:sortOption atIndex:cell.segmentSelect.numberOfSegments animated:NO];
        }
        cell.delegate = self;
        return cell;
    } else {
        SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
        cell.titleLabel.text = self.filterValues.categories[indexPath.row][@"name"];
        cell.on = [self.filterSelections.selectedCategories containsObject:self.filterValues.categories[indexPath.row]];
        cell.delegate = self;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // [self performSegueWithIdentifier:@"openPhotoDetailView" sender:self];
    // [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Switch cell delegate methods

- (void)switchCell:(SwitchCell *)cell didUpdateValue:(BOOL)value{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
   
    switch (indexPath.section) {
        case 0:
            if(value)  {
                [self.filterSelections.selectedDeal addObject:self.filterValues.deals[indexPath.row]];
            } else {
                [self.filterSelections.selectedDeal removeObject:self.filterValues.deals[indexPath.row]];
            }
            break;
        case 3: {
            if(value)  {
                [self.filterSelections.selectedCategories addObject:self.filterValues.categories[indexPath.row]];
            } else {
                [self.filterSelections.selectedCategories removeObject:self.filterValues.categories[indexPath.row]];
            }
            break;
        }
    }
}

- (void)segmentCell:(SegmentCell *)cell didUpdateValue:(BOOL)value{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];

     switch (indexPath.section) {
        case 1:
             if(value)  {
                 self.filterSelections.selectedSort = self.filterValues.sortOptions[value];
             } else {
                 self.filterSelections.selectedSort = nil;
             }
            break;
        case 2: {
            if(value)  {
                self.filterSelections.selectedDistance = self.filterValues.distanceOptions[value];
            } else {
                self.filterSelections.selectedDistance = nil;
            }
            break;
        }
     }
}


#pragma mark - Private methods

-(NSDictionary *) filters {
    NSMutableDictionary *filters = [NSMutableDictionary dictionary];
    
    if (self.filterSelections.selectedCategories.count > 0 ){
        NSMutableArray *names = [NSMutableArray array];
        for (NSDictionary *category in self.filterSelections.selectedCategories) {
            [names addObject:category[@"code"]];
        }
        NSString *categoryFilter = [names componentsJoinedByString:@", "];
        [filters setObject:categoryFilter forKey:@"category_filter"];
    }

    if (self.filterSelections.selectedDeal.count > 0 ) {
        [filters setObject:@"YES" forKey:@"deals_filter"];
    }
    /*
    if (self.filterSelections.selectedDistance) {
        [filters setObject:self.filterSelections.selectedDistance forKey:@"radius_filter"];
    }

    if (self.filterSelections.selectedSort) {
        [filters setObject:self.filterSelections.selectedSort forKey:@"sort"];
    }
    */    
    NSLog(@"filters : %@", filters);
    return filters;
}

-(void)onCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)onApplyButton {
    [self.delegate filtersViewController:self didChageFilters:self.filters];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
