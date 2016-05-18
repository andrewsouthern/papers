
#import "LoadingHUD.h"

static LoadingHUD* loadingHUD = nil;

@implementation LoadingHUD

@synthesize loadingLabel;

#define DEFAULT_WIDTH 140
#define DEFAULT_HEIGHT 100

+(LoadingHUD *) loadingHUD {
    if (loadingHUD==nil)
		loadingHUD=[[LoadingHUD alloc] initWithFrame:CGRectMake(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT)];
	return loadingHUD;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | 
        UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        
        // Initialization code.
		double offset = DEFAULT_HEIGHT/2.0;
		loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, DEFAULT_HEIGHT-2*offset/3.0, DEFAULT_WIDTH, offset/2)];
        loadingLabel.textAlignment=NSTextAlignmentCenter;
		loadingLabel.backgroundColor=[UIColor clearColor];
		loadingLabel.font=[UIFont boldSystemFontOfSize:14];
		loadingLabel.textColor=[UIColor whiteColor];
        loadingLabel.text = @"Loading image";
		
		backgroundView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT)];
        backgroundView.alpha=0.25;
		backgroundView.backgroundColor=[UIColor blackColor];
        backgroundView.layer.cornerRadius=10;
        
        activityIndicator = [[UIActivityIndicatorView new] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityIndicator.center=CGPointMake( DEFAULT_WIDTH/2, DEFAULT_HEIGHT/3);
		[activityIndicator startAnimating];

		[self addSubview:backgroundView];
		[self addSubview:loadingLabel];
        [self addSubview:activityIndicator];
		
    }
    
    return self;
}

-(void)setLoadingText:(NSString *)loadingText{
	loadingLabel.text = loadingText;
}

-(void) showInView:(UIView*)view {
	self.alpha=1.0;
    self.transform=CGAffineTransformMakeScale(1, 1);
    self.center=CGPointMake(view.bounds.size.width/2.0, view.bounds.size.height/2.0);
    [view addSubview:self];
}

-(void) hideActivityIndicator {
    [self removeFromSuperview];
}


@end
