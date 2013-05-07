//
//  SelectWPComBlogVisibilityViewController.m
//  WordPress
//
//  Created by Sendhil Panchadsaram on 4/16/13.
//  Copyright (c) 2013 WordPress. All rights reserved.
//

#import "SelectWPComBlogVisibilityViewController.h"

@interface SelectWPComBlogVisibilityViewController () {
    NSArray *_visibilityOptions;
}

@end

@implementation SelectWPComBlogVisibilityViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];

    if (self) {
        _visibilityOptions = @[
                               NSLocalizedString(@"Public", nil),
                               NSLocalizedString(@"Private", nil),
                               NSLocalizedString(@"Hidden", nil)];
        _currentBlogVisibility = WordPressComApiBlogVisibilityPublic;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"Blog Visibility", nil);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_visibilityOptions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == self.currentBlogVisibility) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = [_visibilityOptions objectAtIndex:indexPath.row];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WordPressComApiBlogVisibility visibility;
    if (indexPath.row == 0) {
        visibility = WordPressComApiBlogVisibilityPublic;
    } else if (indexPath.row == 1) {
        visibility = WordPressComApiComBlogVisibilityPrivate;
    } else {
        visibility = WordPressComApiBlogVisibilityHidden;
    }
    [self.delegate selectWPComBlogVisibilityViewController:self didSelectBlogVisibilitySetting:visibility];
    [self.navigationController popViewControllerAnimated:YES];
}

@end