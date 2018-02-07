//
//  CakeCell.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "CakeCell.h"
#import "Cake_List-Swift.h"

@interface CakeCell()

@property (nonatomic, strong, nullable) NSURLSessionDownloadTask * downloadTask;


@end;

@implementation CakeCell

-(void) prepareForReuse {
    [super prepareForReuse];
    [self.downloadTask cancel];
    self.downloadTask = nil;
}

-(void) configureCellWith:(Cake*) cake {
    
    self.titleLabel.text = cake.title;
    self.descriptionLabel.text = cake.desc;
    NSURL *aURL = [NSURL URLWithString:cake.image];
    self.downloadTask = [self.cakeImageView loadImageWithUrl:aURL];
}


@end
