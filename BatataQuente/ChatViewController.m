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

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self btnEnviar:nil];
    return YES;
}




-(IBAction)btnEnviar:(id)sender{
    NSArray *meuArray = [NSArray arrayWithObjects:[NSNumber numberWithDouble:self.current], self.txtMsg.text, nil];
    
    NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:meuArray];
    NSArray *allPeers = self.appDelegate.mcManager.session.connectedPeers;
    NSError *error;
    
    [self.appDelegate.mcManager.session sendData:dataToSend
                                     toPeers:allPeers
                                    withMode:MCSessionSendDataReliable
                                       error:&error];
    
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
        [[self tempoDecorrido] setText:@"BOOM"];
        [self.timer invalidate];
        return;
    }
    
    self.current -=1;
    int x = self.current;
    [[self tempoDecorrido] setText:[NSString stringWithFormat: @"%d",x]];

    [self.view setNeedsDisplay];
}





@end
