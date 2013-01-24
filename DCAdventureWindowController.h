//
//  DCAdventureWindowController.h
//  pubbed
//
//  Created by Boy van Amstel on 18-01-13.
//  Copyright (c) 2013 Danger Cove. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <WebKit/WebKit.h>

@interface DCAdventureWindowController : NSWindowController

@property (strong, nonatomic) IBOutlet NSTextField *titleLabel;
@property (strong, nonatomic) IBOutlet WebView *webView;

- (id)initWithDelegate:(id)delegate;

@end
