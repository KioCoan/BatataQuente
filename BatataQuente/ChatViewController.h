//
//  ChatViewController.h
//  BatataQuente
//
//  Created by Felipe Costa Nascimento on 18/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface ChatViewController : UIViewController <MCNearbyServiceAdvertiserDelegate, MCSessionDelegate, UITextFieldDelegate>

@property MCPeerID *localPeerID;
@property MCSession *session;
@property MCNearbyServiceAdvertiser *advertiser;

@property (weak, nonatomic) IBOutlet UILabel *lblMsgEnviada;
@property (weak, nonatomic) IBOutlet UITextField *txtMsg;
@property (weak, nonatomic) IBOutlet UILabel *lbMsg;
@property NSTimer *timer;
@property NSNumber *current;
@property (weak, nonatomic) IBOutlet UILabel *tempoDecorrido;

- (IBAction)btnEnviar:(id)sender;
- (IBAction)desconectar:(id)sender;
@end
