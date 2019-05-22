//
//  DragTargetView.m
//  SkipVerification
//
//  Created by Switt Kongdachalert on 20/5/2562 BE.
//  Copyright © 2562 Switt kongdachalert. All rights reserved.
//

#import "DragTargetView.h"
#import "NSBezierPath-BezierPathQuartzUtilities.h"
#import <QuartzCore/QuartzCore.h>
#import <AppKit/NSTextView.h>

@interface AutomaticTextView : NSTextView
@end

@implementation DragTargetView {
    CALayer *_layer;
    CAShapeLayer *borderLayer;
    
    NSTextView *textView;
    
    NSBezierPath *bezierpath;
}
-(id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if(!self) return nil;
    
    [self setup];
    return self;
}
-(id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if(!self) return nil;
    [self setup];
    return self;
}

-(void)setup {
    [self registerForDraggedTypes:@[NSURLPboardType, NSFilenamesPboardType]];
    self.wantsLayer = YES;
    
    textView = [[AutomaticTextView alloc] initWithFrame:self.bounds];
//    textView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    textView.font = [NSFont fontWithName:@"Helvetica" size:20.0];
    textView.textColor = [NSColor colorWithWhite:0.22 alpha:0.9];
    textView.editable = NO;
    textView.string = @"Drag & drop app here";
    textView.backgroundColor = [NSColor clearColor];
    textView.alignment = NSTextAlignmentCenter;
//    [textView setContentCompressionResistancePriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationVertical];
    [self addSubview:textView];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:textView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[tv]-16-|" options:0 metrics:nil views:@{@"tv":textView}]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:textView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:60]];
}

-(CALayer *)makeBackingLayer {
//    bezierpath = [NSBezierPath bezierPathWithRoundedRect:self.bounds xRadius:16 yRadius:16];
    CAShapeLayer *yourViewBorder = [CAShapeLayer layer];
    yourViewBorder.strokeColor = [NSColor grayColor].CGColor;
    yourViewBorder.lineWidth = 4.0;
    yourViewBorder.fillColor = nil;
    yourViewBorder.lineDashPattern = @[@8, @6];
    yourViewBorder.frame = self.bounds;
    yourViewBorder.path = [NSBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, 4, 4) xRadius:16 yRadius:16].quartzPath;
    borderLayer = yourViewBorder;
    _layer = [CALayer layer];
    _layer.cornerRadius = 16.0;
//    _layer.borderColor = [NSColor blackColor].CGColor;
//    _layer.borderWidth = 2.0;
    _layer.backgroundColor = [NSColor colorWithRed:1 green:1 blue:1 alpha:0.5].CGColor;
    [_layer addSublayer:borderLayer];
    return _layer;
}

-(void)layout {
    [super layout];
    borderLayer.path = [NSBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, 4, 4) xRadius:16 yRadius:16].quartzPath;
}

-(NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    NSLog(@"dragging entered..");
    NSString *path = [self pathFromDraggingInfo:sender];
    NSLog(@"Dragged path %@", path);
    if([[path pathExtension] isEqualToString:@"app"]) {
        NSLog(@"valid app");
        _layer.backgroundColor = [NSColor blueColor].CGColor;
        return NSDragOperationCopy;
    }
    else {
        NSLog(@"path ends with %@, not app", [path pathExtension]);
    }
    return NSDragOperationNone;
}
-(void)draggingExited:(id<NSDraggingInfo>)sender {
    _layer.backgroundColor = [NSColor colorWithWhite:1 alpha:0.5].CGColor;
}
-(void)draggingEnded:(id<NSDraggingInfo>)sender {
    _layer.backgroundColor = [NSColor colorWithWhite:1 alpha:0.5].CGColor;
}

-(BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender {
    NSString *path = [self pathFromDraggingInfo:sender];
    NSLog(@"Dragged path %@", path);
    if([[path pathExtension] isEqualToString:@"app"]) {
        NSLog(@"valid app");
        
        return YES;
    }
    else {
        NSLog(@"path ends with %@, not app", [path pathExtension]);
    }
    return YES;
}
-(BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
    NSString *path = [self pathFromDraggingInfo:sender];
    NSLog(@"shouldPerformDragOperationWithPath %@", path);
    [self.delegate receivedDraggedAooPath:path];
    return YES;
}

-(NSString *)pathFromDraggingInfo:(id<NSDraggingInfo>)sender {
    NSArray <NSString *>*filenames = [sender.draggingPasteboard propertyListForType:NSFilenamesPboardType];
    NSString *path = [filenames firstObject];
    return path;
}

@end

@implementation NSObject (DragTargetViewReceiver)
-(void)receivedDraggedAooPath:(NSString *)path {}
@end


@implementation AutomaticTextView
- (NSSize) intrinsicContentSize {
    NSTextContainer* textContainer = [self textContainer];
    NSLayoutManager* layoutManager = [self layoutManager];
    [layoutManager ensureLayoutForTextContainer: textContainer];
    return [layoutManager usedRectForTextContainer: textContainer].size;
}

- (void) didChangeText {
    [super didChangeText];
    [self invalidateIntrinsicContentSize];
}
@end
