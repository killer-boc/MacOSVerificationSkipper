//
//  ViewController.m
//  SkipVerification
//
//  Created by Switt Kongdachalert on 20/5/2562 BE.
//  Copyright © 2562 Switt kongdachalert. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

-(void)performSkipVerificationForAppAtPath:(NSString *)apppath {
    int pid = [[NSProcessInfo processInfo] processIdentifier];
    NSPipe *pipe = [NSPipe pipe];
    NSFileHandle *file = pipe.fileHandleForReading;
    
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = @"/usr/bin/xattr";
    task.arguments = @[@"-d", @"com.apple.quarantine", apppath];
    task.standardOutput = pipe;
    [task setTerminationHandler:^(NSTask *_Nonnull task) {
        NSLog(@"done!");
    }];
    NSLog(@"starting operation");
    [task launch];
}
-(void)receivedDraggedAooPath:(NSString *)path {
    [self performSkipVerificationForAppAtPath:path];
}
@end
