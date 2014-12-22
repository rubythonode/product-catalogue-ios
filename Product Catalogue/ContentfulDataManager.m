//
//  ContentfulDataManager.m
//  Product Catalogue
//
//  Created by Boris Bügling on 18/12/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <ContentfulPersistence/CoreDataManager.h>
#import <ContentfulPersistence/CoreDataFetchDataSource.h>

#import "Asset.h"
#import "Brand.h"
#import "Constants.h"
#import "ContentfulDataManager.h"
#import "Product.h"
#import "ProductCategory.h"
#import "SyncInfo.h"

// TODO: This won't work when we enable space selection
NSString* const BrandContentTypeId = @"sFzTZbSuM8coEwygeUYes";
NSString* const CategoryContentTypeId = @"6XwpTaSiiI2Ak2Ww0oi6qa";
NSString* const ProductContentTypeId = @"2PqfXUJwE8qSYKuM0U6w8M";

@interface ContentfulDataManager ()

@property (nonatomic, readonly) CoreDataManager* manager;

@end

@implementation ContentfulDataManager

@synthesize manager = _manager;

-(CDAClient *)client {
    return self.manager.client;
}

-(NSFetchedResultsController*)fetchedResultsControllerForContentTypeWithIdentifier:(NSString*)contentTypeIdentifier sortDescriptors:(NSArray*)sortDescriptors {
    NSFetchRequest* fetchRequest = [self.manager fetchRequestForEntriesOfContentTypeWithIdentifier:ProductContentTypeId matchingPredicate:nil];
    [fetchRequest setSortDescriptors:sortDescriptors];

    return [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.manager.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
}

- (CoreDataManager *)manager {
    if (_manager) {
        return _manager;
    }

    _manager = [[CoreDataManager alloc] initWithClient:[[CDAClient alloc] initWithSpaceKey:[[NSUserDefaults standardUserDefaults] stringForKey:SPACE_KEY] accessToken:[[NSUserDefaults standardUserDefaults] stringForKey:ACCESS_TOKEN]] dataModelName:@"ProductCatalog"];

    _manager.classForAssets = [Asset class];
    _manager.classForSpaces = [SyncInfo class];

    [_manager setClass:Brand.class forEntriesOfContentTypeWithIdentifier:BrandContentTypeId];
    [_manager setClass:Product.class forEntriesOfContentTypeWithIdentifier:ProductContentTypeId];
    [_manager setClass:ProductCategory.class forEntriesOfContentTypeWithIdentifier:CategoryContentTypeId];

    return _manager;
}

- (void)performSynchronizationWithSuccess:(void (^)())success failure:(CDARequestFailureBlock)failure {
    [self.manager performSynchronizationWithSuccess:success failure:failure];
}

@end