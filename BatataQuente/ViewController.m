//
//  ViewController.m
//  BatataQuente
//
//  Created by Rafael Aparecido de Freitas on 17/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import "ViewController.h"
#import "ChatViewController.h"

@interface ViewController ()

@end

@implementation ViewController



static NSString * XXServiceType = @"BatataQuente";


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self canBecomeFirstResponder ];
    [self.txtNome setDelegate:self];
    [self.btnProcurar setHidden:YES];
    
    
	
}
-(void)viewWillAppear:(BOOL)animated{
    [self.btnActions setTitle:@"Jogar" forState:UIControlStateNormal];
    [self.lblInformativo setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
    
    if ([[[self.btnActions titleLabel]text]isEqualToString:@"Jogar"]) {
        if ([self prepararSessao]) {
            [self.btnActions setTitle:@"Criar Sala" forState:UIControlStateNormal];
            [self.lblInformativo setText:@"Crie uma partida ou aguarde alguém criar"];
            [self.lblInformativo setHidden:NO];
            [self textFieldShouldReturn:self.txtNome];
        }
    }else{
        [self criarSala];
    }
    
    
    
    
}

-(void)criarSala{
    self.browserViewController = [[MCBrowserViewController alloc] initWithBrowser:self.browser session:self.session];
    self.browserViewController.delegate = self;
    
    
    [self presentViewController:self.browserViewController
                       animated:YES
                     completion:^{ [self.browser startBrowsingForPeers]; }];
}

-(BOOL)prepararSessao{
    if (![[self.txtNome text]isEqualToString:@""]) {
        [self idPeer];
        [self criaSessao];
        [self anunciar];
        [self navegador];
        [self.lblInformativo setHidden:YES];
        return YES;
        
    }else{
        [self.lblInformativo setHidden:NO];
        return NO;
    }
}




-(void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID
{
    
    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if([newStr isEqualToString:@"sim"]){
        [self performSegueWithIdentifier:@"viewChat" sender:nil];
    }
}

// Identificação do Ponto

-(void)idPeer
{
    //self.localPeerID = [[MCPeerID alloc] initWithDisplayName:[[UIDevice currentDevice] name]];
    self.localPeerID = [[MCPeerID alloc]initWithDisplayName:self.txtNome.text];
    
}

// Gerência toda a comunicação entre pares

-(void)criaSessao
{
    self.session=[[MCSession alloc]initWithPeer:self.localPeerID securityIdentity:nil encryptionPreference:MCEncryptionNone];
    self.session.delegate = self;
}

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state
{
    //    NSLog(@"Session for peer: %@, changed state to: %i", peerID, state);
    
    //        switch (state)
    //        {
    //            case 2:
    //                [self performSegueWithIdentifier:@"viewChat" sender:nil];
    //            break;
    //
    //            default:
    //                break;
    //        }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //if ([[segue identifier] isEqualToString:@"viewChat"])
    //{
    
    
    
    ChatViewController *chatVc = [segue destinationViewController];

    [chatVc setLocalPeerID:self.localPeerID];
    [chatVc setSession:self.session];
    [chatVc setAdvertiser:self.advertiser];
    
    //}
    
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


-(void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController{
    
    
    NSString *confirmacao = [NSString stringWithFormat:@"sim"];
    
    NSData *data = [confirmacao dataUsingEncoding: NSUTF8StringEncoding];
    
    
    NSError *error = nil;
    if (![self.session sendData:data
                        toPeers:self.session.connectedPeers
                       withMode:MCSessionSendDataReliable
                          error:&error]) {
        NSLog(@"[Error] %@", error);
    }
    
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        [self performSegueWithIdentifier:@"viewChat" sender:nil];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
    }];
    
    
    
}


-(void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info
{
    
    [browser invitePeer:peerID toSession:self.session withContext:nil timeout:3.0];
}

-(void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID
{
    
    
}

-(void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID{
    
}


-(void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress{
    
}








@end
