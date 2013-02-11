//
//  DCAdventureWindowController.h
//  pubbed
//
//  Created by Boy van Amstel on 18-01-13.
//  Copyright (c) 2013 Danger Cove. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <WebKit/WebKit.h>

@interface DCAdventureWindowController : NSWindowController {
    NSAlert *_needToAccept;
}

@property (strong, nonatomic) IBOutlet NSTextField *lblAgreement;
@property (strong, nonatomic) IBOutlet NSButton *btnAgreement;
@property (strong, nonatomic) IBOutlet NSButton *btnDismiss;
@property (strong, nonatomic) IBOutlet WebView *webView;

- (id)initWithDelegate:(id)delegate;
- (IBAction)showNeedToAccept:(id)sender;

@end
