//
//  ViewController.m
//  BatataQuente
//
//  Created by Rafael Aparecido de Freitas on 17/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController



static NSString * XXServiceType = @"BatataQuente";


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.lbMsg.alpha = 0;
    
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)btnProcurar:(id)sender
{
    
    
    self.browserViewController = [[MCBrowserViewController alloc] initWithBrowser:self.browser session:self.session];
    self.browserViewController.delegate = self;
    
    
    [self presentViewController:self.browserViewController
                       animated:YES
                     completion:^{ [self.browser startBrowsingForPeers]; }];
}

- (IBAction)start:(id)sender {
    
    [self idPeer];
    [self criaSessao];
    [self anunciar];
    [self navegador];
    
}

-(void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID
{
    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    
    
    //Força atualização do label
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        //Do any updates to your label here
        [self.lbMsg setText:newStr];
        
    }];
    
    NSLog(@"%@",newStr);
    
    self.lbMsg.alpha = 1;
    
    
    [self.view setNeedsDisplay];
}

// Identificação do Ponto

-(void)idPeer
{
    self.localPeerID = [[MCPeerID alloc] initWithDisplayName:[[UIDevice currentDevice] name]];
    
}

// Gerência toda a comunicação entre pares

-(void)criaSessao
{
    self.session=[[MCSession alloc]initWithPeer:self.localPeerID securityIdentity:nil encryptionPreference:MCEncryptionNone];
    self.session.delegate = self;
}

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state
{
    NSLog(@"Session for peer: %@, changed state to: %i", peerID, state);
    
    }

//Torna o dispositivo detectável para outros pontos/pares

-(void)anunciar
{
    self.advertiser =[[MCNearbyServiceAdvertiser alloc] initWithPeer:self.localPeerID
                                                       discoveryInfo:nil
                                                         serviceType:XXServiceType];
    self.advertiser.delegate = self;
    [self.advertiser startAdvertisingPeer];
    
}

-(void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void (^)(BOOL, MCSession *))invitationHandler
{
    
    
    invitationHandler(YES,self.session);
    [self.advertiser stopAdvertisingPeer];
}

//Navegador procura por pontos/pares

-(void)navegador
{
    
    self.browser = [[MCNearbyServiceBrowser alloc] initWithPeer:self.localPeerID serviceType:XXServiceType];
    self.browser.delegate = self;
    
}

-(void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info
{
    
    [browser invitePeer:peerID toSession:self.session withContext:nil timeout:3.0];
}

-(void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID
{
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"viewChat"])
    {
        // Get reference to the destination view controller
       // viewChat *view = [segue destinationViewController];
        
        // Passe todos os objetos para o controlador
        // [view setMyObjectHere:object];
    }
}

- (IBAction)btnEnviar:(id)sender
{
    NSData *data = [self.txtMsg.text dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    if (![self.session sendData:data
                        toPeers:self.session.connectedPeers
                       withMode:MCSessionSendDataReliable
                          error:&error]) {
        NSLog(@"[Error] %@", error);
    }
    
}
@end
