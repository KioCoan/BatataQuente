//
//  ChatViewController.m
//  BatataQuente
//
//  Created by Felipe Costa Nascimento on 18/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import "ChatViewController.h"
#import "AppDelegate.h"

@interface ChatViewController ()

@property (nonatomic, strong)AppDelegate *appDelegate;

-(void)didReceiveDataWithNotification:(NSNotification *)notification;

@end


@implementation ChatViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    self.txtMsg.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveDataWithNotification:) name:@"MCDidReceiveDataNotification" object:nil];
    
    self.current = 20   ;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(decrementaTempo) userInfo:nil repeats:YES];
    
    NSLog(@"%@",self.players);
    
    if ([[self.players objectAtIndex:0]isEqualToString:@""]) {
        
        [self.players setObject:[[self.appDelegate.mcManager.session myPeerID ] displayName] atIndexedSubscript:0];
        NSLog(@"%@",[self.players objectAtIndex:0]);
    }
    NSLog(@"%@",[self.players objectAtIndex:0]);
    [self.appDelegate.mcManager.session myPeerID ];
}

-(void)viewDidAppear:(BOOL)animated{
    [self.imgBatata setHidden:!self.batata];
    [self.imgBatata setEnabled:self.batata];
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self btnEnviar:nil];
    return YES;
}




-(IBAction)btnEnviar:(id)sender{
    int x;
    NSString *playerRandom;
    
    do {
        x = (arc4random() % [self.players count]);
        playerRandom = [self.players objectAtIndex:x];
    } while ([playerRandom isEqualToString:[self.players objectAtIndex:0]]);
    
    
   
    
    
    
    NSArray *meuArray = [NSArray arrayWithObjects:[NSNumber numberWithDouble:self.current], playerRandom, nil];
    
    
    NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:meuArray];
    NSArray *allPeers = self.appDelegate.mcManager.session.connectedPeers;
    NSError *error;
    
    [self.appDelegate.mcManager.session sendData:dataToSend
                                     toPeers:allPeers
                                    withMode:MCSessionSendDataReliable
                                       error:&error];
    self.batata = NO;
    [self.imgBatata setHidden:!self.batata];
    [self.imgBatata setEnabled:self.batata];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
}


-(void)didReceiveDataWithNotification:(NSNotification *)notification{
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    self.current = [[[notification userInfo] objectForKey:@"tempo"] intValue];

    self.iniciaTempo = YES;
    
    if ([[[notification userInfo] objectForKey:@"embatatado"]isEqualToString: [self.players objectAtIndex:0]]) {
        self.batata = YES;
        [self.imgBatata setHidden:!self.batata];
        [self.imgBatata setEnabled:self.batata];
        NSLog(@"Ta queimando!!!");

    }else{
        self.batata = NO;
        [self.imgBatata setHidden:!self.batata];
        [self.imgBatata setEnabled:self.batata];
        NSLog(@"Esfriou");
    }
    
        
    }];

}



-(void)decrementaTempo{
   // NSLog(@"%f",self.current);
    
    if(!self.iniciaTempo){
        return;
    }else if(self.current <= 0){
        [self.imgBatata setEnabled:NO];
        if (self.batata ) {
            [[self tempoDecorrido] setText:@"Perdeu!!"];
        }else{
            [[self tempoDecorrido] setText:@"Ganhou!"];
        }
        
        
        [self.timer invalidate];
        return;
    }
    
    self.current -=1;
    int x = self.current;
    [[self tempoDecorrido] setText:[NSString stringWithFormat: @"%d",x]];

    [self.view setNeedsDisplay];
}





- (IBAction)voltar:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)btnBatata:(id)sender {
    self.current -=1;
    [self btnEnviar:nil];
}
@end
