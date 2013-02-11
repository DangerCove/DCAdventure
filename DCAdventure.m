//
//  DCAdventure.m
//  AirTube
//
//  Created by Boy van Amstel on 18-01-13.
//  Copyright (c) 2013 Danger Cove. All rights reserved.
//

#import "DCAdventure.h"

@implementation DCAdventure

+ (id)sharedAdventure {
    static DCAdventure *sharedAdventure = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAdventure = [[self alloc] init];
    });
    return sharedAdventure;
}

- (id)initWithRequest:(NSURLRequest *)request {
    if(self = [super init]) {
        _urlRequest = request;
        
        _windowController = [[DCAdventureWindowController alloc] initWithDelegate:self];
        
        _windowClosedCallbacksArray = [[NSMutableArray alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"DCAdventureProperties" ofType:@"plist"];
        _properties = [[NSDictionary alloc] initWithContentsOfFile:path];
        
        [self buildInterface];
    }
    return self;
}
- (id)init {
    NSURLRequest *adventureRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[_properties objectForKey:@"AdventureURL"]]];
    if (self = [self initWithRequest:adventureRequest]) {
    }
    return self;
}


- (void)buildInterface {
    // Title
    _windowController.window.title = [_properties objectForKey:@"DCAdventureName"];
    
    // Agreement
    [_windowController.lblAgreement setStringValue:[_properties objectForKey:@"DCAdventureAgreement"]];
    [_windowController.btnAgreement setTitle:[_properties objectForKey:@"DCAdventureIAgree"]];

    // Dismiss
    [_windowController.btnDismiss setTitle:[_properties objectForKey:@"DCAdventureDismiss"]];
    
    // Web View
    [[_windowController.webView mainFrame] loadRequest:_urlRequest];
}

- (void)show:(WindowClosedBlock)windowClosedBlock {
    [_windowController showWindow:nil];
    [_windowController.window makeKeyAndOrderFront:self];

    if(windowClosedBlock) {
        [_windowClosedCallbacksArray addObject:windowClosedBlock];
    }
}

#pragma mark -
#pragma mark NSWindowDelegate

- (void)windowWillClose:(NSNotification *)notification {
    BOOL accepted = [[[NSUserDefaults standardUserDefaults] objectForKey:@"DCAdventureAccept"] boolValue];
    
    if(accepted == YES) {
        for(WindowClosedBlock callback in _windowClosedCallbacksArray) {
            callback(); // Call callback
        }
        [_windowClosedCallbacksArray removeAllObjects];
    } else {
        [NSApp terminate:self];
    }
}

@end
