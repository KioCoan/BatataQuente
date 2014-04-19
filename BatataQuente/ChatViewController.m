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
    
    self.current = 90;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(decrementaTempo) userInfo:nil repeats:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    //NSLog(@"%@",self.players);
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self btnEnviar:nil];
    return YES;
}




-(IBAction)btnEnviar:(id)sender{
    int x = (arc4random() % [self.players count]);
    
    
    //NSLog(@"%d",x);
    NSString *playerRandom = [self.players objectAtIndex:x];
    NSArray *meuArray = [NSArray arrayWithObjects:[NSNumber numberWithDouble:self.current], self.txtMsg.text, playerRandom, nil];
    
    NSLog(@"%d",[meuArray count]);
    NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:meuArray];
    NSArray *allPeers = self.appDelegate.mcManager.session.connectedPeers;
    NSError *error;
    
    [self.appDelegate.mcManager.session sendData:dataToSend
                                     toPeers:allPeers
                                    withMode:MCSessionSendDataReliable
                                       error:&error];
    self.batata = NO;
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    [self.lblMsgEnviada setText: self.txtMsg.text];
    [self.txtMsg setText:@""];
    [self.txtMsg resignFirstResponder];
}


-(void)didReceiveDataWithNotification:(NSNotification *)notification{
    self.current = [[[notification userInfo] objectForKey:@"tempo"] intValue];

    self.iniciaTempo = YES;
    
    if ([[[notification userInfo] objectForKey:@"embatatado"]isEqualToString: [self.players objectAtIndex:0]]) {
        self.batata = YES;
        NSLog(@"Ta queimando!!!");

    }
    
    
    MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
    NSString *peerDisplayName = peerID.displayName;
    
    NSString *receivedText = [[notification userInfo] objectForKey:@"mensagem"];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        //Do any updates to your label here
        [self.lbMsg setText:[NSString stringWithFormat:@"%@: %@", peerDisplayName, receivedText]];
        
    }];

}



-(void)decrementaTempo{
    NSLog(@"%f",self.current);
    
    if(!self.iniciaTempo){
        return;
    }else if(self.current == 0){
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





@end
