//
//  MasterViewController.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "MasterViewController.h"
#import "CakeCell.h"
#import "Cake_List-Swift.h"
#import "GlobalConstants.h"

@interface MasterViewController ()
@property (strong, nonatomic) DownloadService *downloadService;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNibs];
    [self loadCakeData];
}
#pragma mark - Private Methods

-(void) registerNibs {
    
    UINib *loadingCellNib = [UINib nibWithNibName:@"LoadingCell" bundle:nil];
    [self.tableView registerNib:loadingCellNib forCellReuseIdentifier:@"LoadingCell"];
    
    UINib *nothingFoundcellNib = [UINib nibWithNibName:@"NothingFoundCell" bundle:nil];
    [self.tableView registerNib:nothingFoundcellNib forCellReuseIdentifier:@"NothingFoundCell"];

}

-(void)loadCakeData {
    
    self.downloadService =[DownloadService new];
    [self.downloadService performLoadJSONWith:CakeJSONUrl completion:^(BOOL success) {
        [self.tableView reloadData];
        
    }];
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.downloadService.state) {
        case StateNotSearchedYet:
            return 0;
        case StateLoading:
            return 1;
        case StateNoResults:
            return 1;
        case StateResults:
            return self.downloadService.cakeLists.count;
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    switch (self.downloadService.state) {
        case StateLoading:
        {
            UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"LoadingCell"];

            return cell;
        }
        case StateNoResults:
        {
            UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"NothingFoundCell"];
            
            return cell;
        }
        case StateResults:
        {
            CakeCell *cell = (CakeCell*)[tableView dequeueReusableCellWithIdentifier:@"CakeCell"];
            
            Cake * cake = self.downloadService.cakeLists[indexPath.row];
            [cell configureCellWith:cake];
            return cell;
        }
        default:
            break;
    }
    

    return cell;
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
