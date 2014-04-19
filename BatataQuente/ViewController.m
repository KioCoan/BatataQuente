//
//  ViewController.m
//  BatataQuente
//
//  Created by Rafael Aparecido de Freitas on 17/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ChatViewController.h"

@interface ViewController ()

@property (nonatomic, strong)AppDelegate *appDelegate;
@property (nonatomic, strong) NSMutableArray *arrConnectedDevices;

@end

@implementation ViewController



static NSString * XXServiceType = @"batata-quente";


- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self canBecomeFirstResponder ];
    [self.txtNome setDelegate:self];
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[self.appDelegate mcManager] setupPeerAndSessionWithDisplayName:[UIDevice currentDevice].name];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(peerDidChangeStateWithNotification:)
                                                 name:@"MCDidChangeStateNotification"
                                               object:nil];
	
    self.arrConnectedDevices = [[NSMutableArray alloc] init];
    
    [self.tbldispositivos setDelegate:self];
    [self.tbldispositivos setDataSource:self];
    self.btnVisivel = false;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    _appDelegate.mcManager.peerID = nil;
    _appDelegate.mcManager.session = nil;
    _appDelegate.mcManager.browser = nil;
    
    if (self.btnVisivel) {
        [_appDelegate.mcManager.advertiser stop];
    }
    _appDelegate.mcManager.advertiser = nil;
    
    
    [_appDelegate.mcManager setupPeerAndSessionWithDisplayName:self.txtNome.text];
    [_appDelegate.mcManager setupMCBrowser];
    
    return YES;
}



- (IBAction)btnProcurar:(id)sender
{
    if(!self.btnVisivel){
        [self visivel:nil];
    }
    
    [[self.appDelegate mcManager] setupMCBrowser];
    [[[self.appDelegate mcManager] browser] setDelegate:self];
    [self presentViewController:[[self.appDelegate mcManager] browser] animated:YES completion:nil];
    
}

-(IBAction)visivel:(id)sender{
    
   // NSLog(@"%@", [[self txtNome]text]);
    if ([[[self txtNome]text]isEqualToString:@""]) {
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:@"Dados inválidos"
                                           message:@"Seu nome é obrigatório"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
        [alert show];
        
        
    }else{
        
        self.btnVisivel = !self.btnVisivel;
        [[self arrConnectedDevices]addObject: [[self txtNome]text]];
        [self.appDelegate.mcManager advertiseSelf:self.btnVisivel];
    }
    
    
    
}

-(IBAction)disconnect:(id)sender{
    [self.appDelegate.mcManager.session disconnect];
    
    self.txtNome.enabled = YES;
    
    [self.arrConnectedDevices removeAllObjects];
    [self.tbldispositivos reloadData];
}


- (IBAction)btnIniciar:(id)sender {
    NSLog(@"%@",self.arrConnectedDevices);
    
    ChatViewController *chat = [self.storyboard instantiateViewControllerWithIdentifier:@"viewChat"];;
    [chat setPlayers:self.arrConnectedDevices];
    
    chat.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:chat animated:YES completion:nil];
    
    
    
    //[self performSegueWithIdentifier:@"viewChat" sender:nil];
}


-(void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController{
    [self.appDelegate.mcManager.browser dismissViewControllerAnimated:YES completion:nil];
}


-(void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController{
    [self.appDelegate.mcManager.browser dismissViewControllerAnimated:YES completion:nil];
}


-(void)peerDidChangeStateWithNotification:(NSNotification *)notification{
    MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
    NSString *peerDisplayName = peerID.displayName;
    MCSessionState state = [[[notification userInfo] objectForKey:@"state"] intValue];
    
    if (state != MCSessionStateConnecting) {
        if (state == MCSessionStateConnected) {
            [self.arrConnectedDevices addObject:peerDisplayName];
        }
        else if (state == MCSessionStateNotConnected){
            if ([self.arrConnectedDevices count] > 0) {
                int indexOfPeer = [_arrConnectedDevices indexOfObject:peerDisplayName];
                [self.arrConnectedDevices removeObjectAtIndex:indexOfPeer];
            }
        }
        [self.tbldispositivos reloadData];
        
        BOOL peersExist = ([[self.appDelegate.mcManager.session connectedPeers] count] == 0);
        [self.btnDisconnect setEnabled:!peersExist];
        [self.txtNome setEnabled:peersExist];
        
        [self.tbldispositivos setNeedsDisplay];
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrConnectedDevices count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }
    
    cell.textLabel.text = [self.arrConnectedDevices objectAtIndex:indexPath.row];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}




@end
