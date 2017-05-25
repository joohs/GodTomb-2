//
//  ProgressSettingsView.h
//  BReader
//
//  Created by ruikye on 14-5-11.
//
//

#import <UIKit/UIKit.h>

@interface ProgressSettingsView : UIView
- (void)prevChapter:(id)target sel:(SEL)sel;
- (void)nextChapter:(id)target sel:(SEL)sel;
- (void)updateTitle:(NSString *)title;
@end
