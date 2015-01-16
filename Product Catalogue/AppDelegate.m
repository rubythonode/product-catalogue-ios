//
//  AppDelegate.m
//  Product Catalogue
//
//  Created by Boris Bügling on 10/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <CocoaPods-Keys/ProductCatalogueKeys.h>
#import <ContentfulStyle/UIFont+Contentful.h>

#import "AppDelegate.h"
#import "Constants.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)app didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self writeKeysToUserDefaults];

    [[UINavigationBar appearance] setTitleTextAttributes:@{ NSFontAttributeName: UIFont.titleBarFont,NSForegroundColorAttributeName: UIColor.blackColor }];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSFontAttributeName: UIFont.tabTitleFont } forState:UIControlStateNormal];

    self.window.backgroundColor = UIColor.whiteColor;
    return YES;
}

-(void)writeKeysToUserDefaults {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    ProductCatalogueKeys* keys = [ProductCatalogueKeys new];

    if (![defaults stringForKey:SPACE_KEY]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Info", nil) message:FIRST_LAUNCH_MESSAGE delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];

        [defaults setValue:keys.productCatalogueSpaceId forKey:SPACE_KEY];
    }

    if (![defaults stringForKey:ACCESS_TOKEN]) {
        [defaults setValue:keys.productCatalogueAccesToken forKey:ACCESS_TOKEN];
    }
}

@end
