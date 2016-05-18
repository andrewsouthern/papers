
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LoadingHUD : UIView {
	UILabel *loadingLabel;
	UIView *backgroundView;
	UIActivityIndicatorView* activityIndicator;
   
}

@property (readonly) UILabel *loadingLabel;

+(LoadingHUD *) loadingHUD;
-(void)setLoadingText:(NSString *)loadingText;
-(void)hideActivityIndicator;
-(void)showInView:(UIView*)view;

@end
