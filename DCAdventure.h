//
//  DCAdventure.h
//  AirTube
//
//  Created by Boy van Amstel on 18-01-13.
//  Copyright (c) 2013 Danger Cove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCAdventureWindowController.h"

typedef void (^WindowClosedBlock)();

@interface DCAdventure : NSObject <NSWindowDelegate> {
    NSMutableArray *_windowClosedCallbacksArray;
    
    NSDictionary *_properties;

    NSURLRequest *_urlRequest;
}

+ (id)sharedAdventure;

@property DCAdventureWindowController *windowController;

- (id)initWithRequest:(NSURLRequest *)request;
- (void)show;
- (void)show:(WindowClosedBlock)showBlock;

@end
