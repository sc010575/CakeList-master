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

@interface MasterViewController ()
@property (strong, nonatomic) NSArray *objects;
@property (strong, nonatomic) DownloadService *downloadService;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"LoadingCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"LoadingCell"];

    self.downloadService =[DownloadService new];
    [self.downloadService performSearchWith:^(BOOL success) {
        [self.tableView reloadData];
    }];
 //    [self getData];
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.downloadService.state) {
        case StateNotSearchedYet:
            return 0;
            break;
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
    
    switch (self.downloadService.state) {
        case StateLoading:
        {
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"LoadingCell"];

            return cell;
        }
        case StateNoResults:
        {
            UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"LoadingCell"];
            
            return cell;
        }
        case StateResults:
        {
            CakeCell *cell = (CakeCell*)[tableView dequeueReusableCellWithIdentifier:@"CakeCell"];
            
            // NSDictionary *object = self.objects[indexPath.row];
            Cake * cake = self.downloadService.cakeLists[indexPath.row];
            [cell configureCellWith:cake];
//            cell.titleLabel.text = cake.title;
//            cell.descriptionLabel.text = cake.description;
//            NSURL *aURL = [NSURL URLWithString:cake.image];
//            [cell.cakeImageView loadImageWithUrl:aURL];
            
            //    NSURL *aURL = [NSURL URLWithString:object[@"image"]];
            //    NSData *data = [NSData dataWithContentsOfURL:aURL];
            //    UIImage *image = [UIImage imageWithData:data];
            //    [cell.cakeImageView setImage:image];
              return cell;
        }
        default:
            break;
    }
    

    return nil;
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)getData{
    
    NSURL *url = [NSURL URLWithString:@"https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json"];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSError *jsonError;
    id responseData = [NSJSONSerialization
                       JSONObjectWithData:data
                       options:kNilOptions
                       error:&jsonError];
    if (!jsonError){
        self.objects = responseData;
        [self.tableView reloadData];
    } else {
    }
    
}

@end
