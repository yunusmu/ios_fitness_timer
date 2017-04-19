//
//  ViewController.m
//  FitnessTimer
//
//  Created by Joseph Apps on 18/04/2017.
//  Copyright © 2017 Joseph Apps. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UIButton *speakButton;
@property (weak, nonatomic) IBOutlet UILabel *timerIntervalValueLabel;
@property (weak, nonatomic) IBOutlet UISlider *timerIntervalSlider;
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;

@property (nonatomic) AVSpeechSynthesizer *speechSynthesizer;
@property (nonatomic) NSTimer *counterTimer;
@property (nonatomic) int counter;
@property (nonatomic) int intervalCounter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // initialize the speech synthesizer
    self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    self.timerIntervalValueLabel.text = [NSString stringWithFormat:@"%.0f", self.timerIntervalSlider.value];
    self.counter = 0;
    self.intervalCounter = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)speakButtonTapped:(id)sender {
    
    AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:self.inputField.text];
    [utterance setRate:0.5f];
    [utterance setVoice:[AVSpeechSynthesisVoice voiceWithLanguage:@"tr-TR"]];
    [synthesizer speakUtterance:utterance];
}

- (IBAction)startButtonTapped:(id)sender {
    
    self.counterTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTicked:) userInfo:nil repeats:YES];
}

- (void)timerTicked:(NSTimer*)timer {
    
    int timeInterval = [self.timerIntervalValueLabel.text intValue];
    
    ++self.counter;
    
    self.counterLabel.text = [NSString stringWithFormat:@"%d", self.counter];
    
    if(self.counter % timeInterval == 0) {
        ++self.intervalCounter;
        
        AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:[NSString stringWithFormat:@"%d", self.intervalCounter]];
        
        [utterance setRate:0.5f];
        [utterance setVoice:[AVSpeechSynthesisVoice voiceWithLanguage:@"tr-TR"]];
        
        [self.speechSynthesizer speakUtterance:utterance];
        
        NSLog(@"Interval #%d", self.intervalCounter);
    }
}

- (IBAction)timerIntervalSliderValueChanged:(id)sender {
    
    int refinedValue = (((int)self.timerIntervalSlider.value) / 5) * 5;
    
    self.timerIntervalValueLabel.text = [NSString stringWithFormat:@"%d", refinedValue];
}

@end
