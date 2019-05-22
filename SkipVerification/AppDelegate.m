//
//  AppDelegate.m
//  SkipVerification
//
//  Created by Switt Kongdachalert on 20/5/2562 BE.
//  Copyright © 2562 Switt kongdachalert. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    _window = [[[NSApplication sharedApplication] windows] firstObject];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag
{
    if (flag) {
        return NO;
    }
    else
    {
        [self.window makeKeyAndOrderFront:self];// Window that you want open while click on dock app icon
        return YES;
    }
}

@end
