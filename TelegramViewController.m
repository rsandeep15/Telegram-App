//
//  TelegramTranslatorViewController.m
//  Telegram App
//
//  Created by Sandeep  Raghunandhan on 7/22/14.
//  Copyright (c) 2014 Sandeep  Raghunandhan. All rights reserved.
//

#import "TelegramViewController.h"
#import "MorseCode.h"

@interface TelegramViewController()
@property (weak, nonatomic) IBOutlet UILabel *inLabel;
@property (weak, nonatomic) IBOutlet UILabel *outLabel;

@property IBOutlet UITextView *inputText;
@property IBOutlet UITextView *outputText;

@property (weak, nonatomic) IBOutlet UIButton *translateButton;
@property (weak, nonatomic) IBOutlet UIButton *swapButton;
@property (weak, nonatomic) IBOutlet UIButton *clear;
@property (weak, nonatomic) IBOutlet UISegmentedControl *selector;

@property (weak, nonatomic) AVCaptureDevice *light;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (strong, nonatomic)AVAudioPlayer *DOT;
@property (strong, nonatomic)AVAudioPlayer *DASH;

@end

@implementation TelegramViewController
-(instancetype)init
{
    self = [super init];
    if(self)
    {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Translator";
        self.light = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        // code to add sound to iPhone App from: http://stackoverflow.com/questions/10161126/how-to-add-a-background-sound-to-iphone-app
        // Sound clips for DOT and DASH from third-party site
        NSString *path1 = [[NSBundle mainBundle]pathForResource:@"DOT" ofType:@"wav"];
        _DOT = [[AVAudioPlayer alloc]initWithContentsOfURL: [NSURL fileURLWithPath:path1 ]error:nil];
        [_DOT prepareToPlay];
        
        NSString *path2 = [[NSBundle mainBundle]pathForResource:@"DASH" ofType:@"wav"];
        _DASH = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath: path2] error:nil];
        [_DASH prepareToPlay];
        
    }
    return self;
}
-(void)viewDidLoad
{
    
    NSMutableArray *views = [[NSMutableArray alloc]init];
    [views addObject:_inLabel] ;
    [views addObject:_outLabel] ;
    [views addObject:_inputText] ;
    [views addObject:_outputText] ;
    [views addObject:_translateButton] ;
    [views addObject:_swapButton ];
    [views addObject:_clear] ;
    [views addObject:_selector];
    
    for (UIView *view in views)
    {
        // from http://stackoverflow.com/questions/18384832/no-round-rect-button/in-xcode-5
        // Code to make IBOutlets (buttons, labels, textboxes) have a rounded edge
        CALayer *layer = [view layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:5.0f];
        
        // Add the motion effects to each view
        UIInterpolatingMotionEffect *motionEffect = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @-15;
        motionEffect.maximumRelativeValue = @15;
        [view addMotionEffect:motionEffect];
    }
    
    
}

- (IBAction)swap:(id)sender {
    NSString *temp = _inputText.text;
    _inputText.text = _outputText.text;
    _outputText.text = temp;
    
    
    // Reset the colors to black
    _inputText.textColor = [UIColor blackColor];
    _outputText.textColor = [UIColor blackColor];
    
    NSString *temp2 = _inLabel.text;
    _inLabel.text = _outLabel.text;
    _outLabel.text = temp2;
}
-(void)turnOnLight
{
    if ([_light hasTorch])
    {
        [_light lockForConfiguration:nil];
        [_light setTorchModeOnWithLevel:_slider.value error:nil];
        [_light unlockForConfiguration];
    }
}
-(void)turnOffLight
{
    if ([_light hasTorch])
    {
        [_light lockForConfiguration:nil];
        [_light setTorchMode:AVCaptureTorchModeOff];
        [_light unlockForConfiguration];
    }
}
-(void)morseToLight: (NSString *)morse
{
    if (_selector.selectedSegmentIndex != 1)
    {
        // If the user changes his/her/its mind while the lights are still flashing, stop the
        // flashing.
        return;
    }
    if (morse.length != 0)
    {
        float unit = 0.5;
        char c = [morse characterAtIndex:0];
        if (c == '.')
        {
            [self performSelector: @selector (turnOffLight) withObject:nil afterDelay:unit];
            [self turnOnLight];
            morse = [morse substringFromIndex:1];
            [self performSelector:@selector(morseToLight:) withObject:morse afterDelay:unit];
        }
        else if (c == '-')
        {
            [self performSelector: @selector (turnOffLight) withObject:nil afterDelay:unit];
            [self turnOnLight];
            morse = [morse substringFromIndex:1];
            [self performSelector:@selector(morseToLight:) withObject:morse afterDelay:unit * 3];
        }
        else if (c == '/')
        {
            morse = [morse substringFromIndex:1];
            [self performSelector:@selector(morseToLight:) withObject:morse afterDelay:unit * 7];
        }
        else
        {
            morse = [morse substringFromIndex:1];
            [self morseToLight:morse];
        }
    }
}

-(void)morseToSound: (NSString *)morse
{
    _DOT.volume = _slider.value;
    _DASH.volume = _slider.value;
    
    NSLog(@"A Dot lasts %f seconds", _DOT.duration);
    NSLog(@"A Dash lasts %f seconds", _DASH.duration);
    
    NSTimeInterval delay = 0.4;
    
    for (int i = 0; i < morse.length; i++)
    {
        char c = [morse characterAtIndex:i];
        if (c == '.')
        {
            _DOT.currentTime = 0;
            [_DOT performSelector: @selector(play) withObject:nil afterDelay:i * delay];
        }
        else if (c == '-')
        {
            _DASH.currentTime = 0;
            [_DASH performSelector: @selector(play) withObject:nil afterDelay:i * delay];
        }
    }
}
-(IBAction)translate:(id)sender
{
    MorseCode *morse = [[MorseCode alloc]init];
    if ([_inLabel.text  isEqual: @"English"])
    {
        _inputText.textColor = [UIColor blackColor];
        _outputText.textColor = [UIColor blackColor];
        _outputText.text = [morse englishToMorse:_inputText.text];
        [_outputText setNeedsDisplay];
    }
    else if ([_inLabel.text  isEqual: @"Morse"])
    {
        _outputText.textColor = [UIColor blackColor];
        _inputText.textColor = [UIColor blackColor];
        _outputText.text = [morse morseToEnglish:_inputText.text];
    }
    
    [_inputText resignFirstResponder];
    
    if(_selector.selectedSegmentIndex == 1)
    {
        
        if ([_inLabel.text isEqual:@"Morse"])
        {
            _inputText.textColor = [UIColor redColor];
            [self morseToLight:[_inputText.text copy]];
        }
        else
        {
            _outputText.textColor = [UIColor redColor];
            [self morseToLight:[_outputText.text copy]];
            
        }
    }
    
    if (_selector.selectedSegmentIndex == 2)
    {
        if ([_inLabel.text isEqual:@"Morse"])
        {
            _inputText.textColor = [UIColor greenColor];
            [self morseToSound:_inputText.text];
        }
        else{
            _outputText.textColor = [UIColor greenColor];
            [self morseToSound:_outputText.text];
        }
    }
    
    _translateButton.alpha = 0.0;
    [UIView animateWithDuration:0.5 animations:^{
        _translateButton.alpha = 1.0;
    }];

}
-(IBAction)tapHandler:(id)sender
{
    [_inputText resignFirstResponder];
    [_outputText resignFirstResponder];
}
- (IBAction)clear:(id)sender
{
    _inputText.text = @"";
    _outputText.text = @"";
}


@end
