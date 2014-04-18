//
//  ChatViewController.m
//  BatataQuente
//
//  Created by Felipe Costa Nascimento on 18/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import "ChatViewController.h"


@implementation ChatViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.lblMsgEnviada.alpha = 0;
    self.lbMsg.alpha = 0;
    self.txtMsg.delegate = self;
    self.session.delegate = self;
    self.advertiser.delegate = self;
    
    
    [self setCurrent:90];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //NSLog(@"Hi");
}
-(void)viewDidAppear:(BOOL)animated{
    [self iniciaContagem];
}


-(void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress{
    
}

-(void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID{
    
}

-(void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void (^)(BOOL, MCSession *))invitationHandler{
    
}

-(void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error{
    
}


-(void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state{
    
}

-(void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID{

    
    NSLog(@"ID - %@", peerID.displayName);
    //NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"%d", [[arr objectAtIndex:0] intValue]);
    
    NSNumber *x = [arr objectAtIndex:0];
    
    self.current = [x doubleValue];
    
    
    //NSLog(@"%@",arr);
    //Força atualização do label
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        //Do any updates to your label here
        [self.lbMsg setText:[arr objectAtIndex:1]];
        
        
    }];
    NSLog(@"%@", [arr objectAtIndex:1]);
    [[self lbMsg] setAlpha:1];
    [self.view setNeedsDisplay];
}

-(void)iniciaContagem{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(decrementaTempo) userInfo:nil repeats:YES];
}

-(void)decrementaTempo{
    NSLog(@"%f",self.current);
    
    self.current -=1;
    int x = self.current;
    [[self tempoDecorrido] setText:[NSString stringWithFormat: @"%d",x]];
    
    //    self.current = (NSNumber*)[tempo userInfo];
//    
//    int minutos = [self.current intValue] / 60;
//    
//    int segundos = [self.current intValue] - minutos *60;
//    
//    self.tempoDecorrido.text = [NSString stringWithFormat:@"%d:%d", minutos, segundos];
    
}

//-(void)zerarTimer{
//    if (self.timer) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
//}


- (IBAction)btnEnviar:(id)sender
{
   // NSArray *arrayPts = [[NSArray alloc]initWithObjects:10,20,30, nil];
    
    //[self zerarTimer];
    NSNumber *x = [NSNumber numberWithDouble:self.current];

    
    NSArray *meuArray = [[NSArray alloc] initWithObjects:x, self.txtMsg.text, nil];
    
    //NSData *data = [self.txtMsg.text dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:meuArray];
    
    //NSLog(@"%@", self.session.connectedPeers);
    
    NSError *error = nil;
    if (![self.session sendData:data
                        toPeers:self.session.connectedPeers
                       withMode:MCSessionSendDataReliable
                          error:&error]) {
        NSLog(@"[Error] %@", error);
        
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Falha ao conectar" message:@"Houve uma falha ao conectar, reinicie o jogo." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alerta show];
    }
    
    
    [[self lblMsgEnviada] setText:self.txtMsg.text];
    [self.txtMsg setText:@""];
    self.lblMsgEnviada.alpha = 1;
}

- (IBAction)desconectar:(id)sender {
    [[self session] disconnect];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.txtMsg resignFirstResponder];
    [self btnEnviar:nil];
    return YES;
}

@end
