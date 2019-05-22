//
//  DragTargetView.h
//  SkipVerification
//
//  Created by Switt Kongdachalert on 20/5/2562 BE.
//  Copyright © 2562 Switt kongdachalert. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (DragTargetViewReceiver)
-(void)receivedDraggedAooPath:(NSString *)path;
@end
IB_DESIGNABLE
@interface DragTargetView : NSView
@property (weak) IBOutlet id delegate;

@end

NS_ASSUME_NONNULL_END
