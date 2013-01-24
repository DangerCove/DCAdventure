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

- (id)init {
    if (self = [super init]) {
        _windowController = [[DCAdventureWindowController alloc] initWithDelegate:self];
        
        _windowClosedCallbacksArray = [[NSMutableArray alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"DCAdventureProperties" ofType:@"plist"];
        _properties = [[NSDictionary alloc] initWithContentsOfFile:path];
        
        [self buildInterface];
    }
    return self;
}

- (void)buildInterface {
    // Title
    _windowController.titleLabel.stringValue = [NSString stringWithFormat:_windowController.titleLabel.stringValue, [[_properties objectForKey:@"DCAdventureNumber"] intValue], [_properties objectForKey:@"DCAdventureName"]];
    
    // Web View
    NSURLRequest *adventureRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[_properties objectForKey:@"AdventureURL"]]];
    [[_windowController.webView mainFrame] loadRequest:adventureRequest];
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
