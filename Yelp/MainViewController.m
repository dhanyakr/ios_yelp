//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"
#import "Business.h"
#import "BusinessCell.h"
#import "FiltersViewController.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) NSArray *businesses;

- (void)fetchBusinessWithQuery:(NSString *)query params:(NSDictionary *)params;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        [self fetchBusinessWithQuery:@"Restaurants" params:nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // self.tableView.rowHeight = UITableViewAutomaticDimension;
    // self.title = @"Yelp";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(onFilterButton)];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    searchBar.placeholder = @"Restaurants";
    self.navigationItem.titleView = searchBar;
    self.navigationItem.titleView.frame = CGRectMake(0, 0, 170,44);
    
    self.navigationController.navigationBar.barTintColor =  [UIColor redColor];
    self.navigationController.navigationBar.tintColor =  [UIColor whiteColor];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // hide keyboard
    [searchBar resignFirstResponder];
    
    [self fetchBusinessWithQuery:searchBar.text params:nil];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    // hide keyboard
    [searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.businesses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
    cell.business = self.businesses[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // [self performSegueWithIdentifier:@"openPhotoDetailView" sender:self];
    // [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - Filter delegate methods

-(void)filtersViewController:(FiltersViewController *)filtersViewController didChageFilters:(NSDictionary *)filters{
    
    // fire a new network event.
    NSLog(@"fire new network event: %@", filters);
    [self fetchBusinessWithQuery:@"Restaurants" params:filters];
}

#pragma mark - Private methods

-(void)fetchBusinessWithQuery:(NSString *)query params:(NSDictionary *)params  {
    [self.client searchWithTerm:query params:params success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"response: %@", response);
        NSArray *businessesDictionaries = response[@"businesses"];
        self.businesses = [Business businessesWithDictionaries:businessesDictionaries];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];

}
-(void)onFilterButton {
    FiltersViewController *vc = [[FiltersViewController alloc] init];
    vc.delegate = self;
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}
@end
