//
//  DCAdventureWindowController.m
//  pubbed
//
//  Created by Boy van Amstel on 18-01-13.
//  Copyright (c) 2013 Danger Cove. All rights reserved.
//

#import "DCAdventureWindowController.h"

@interface DCAdventureWindowController ()

@end

@implementation DCAdventureWindowController

- (id)initWithDelegate:(id)delegate {
    if(self = [super initWithWindowNibName:@"DCAdventureWindow"]) {
        self.window.delegate = delegate;
    }
    return self;
}

#pragma mark -
#pragma mark Interface Methods

- (IBAction)dismiss:(id)sender {
    [self close];
}

@end
