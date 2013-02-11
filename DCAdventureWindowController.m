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

- (void)awakeFromNib {
    [_webView setDrawsBackground:NO];
}

#pragma mark -
#pragma mark Interface Methods

- (IBAction)dismiss:(id)sender {
    [self close];
}

- (IBAction)showNeedToAccept:(id)sender {
    if(!_needToAccept) {
        _needToAccept = [[NSAlert alloc] init];
        
        [_needToAccept setAlertStyle:NSWarningAlertStyle];
        [_needToAccept setMessageText:NSLocalizedString(@"Agreement", nil)];
        [_needToAccept setInformativeText:NSLocalizedString(@"Read the agreement below and check the box to get started with our app. Thanks!", nil)];
        [_needToAccept addButtonWithTitle:NSLocalizedString(@"OK", nil)];
    }
    [_needToAccept beginSheetModalForWindow:self.window modalDelegate:self didEndSelector:nil contextInfo:nil];
}

@end
