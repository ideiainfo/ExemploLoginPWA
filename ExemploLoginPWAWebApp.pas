unit ExemploLoginPWAWebApp;

interface

Uses
 System.Classes, System.SysUtils, System.UITypes,
 D2Bridge.ServerControllerBase, D2Bridge.Types,
 Prism.Session, Prism.Server.HTTP.Commom, Prism.Types, Prism.Interfaces,
 ExemploLoginPWA_Session, Data.DB, Datasnap.DBClient;

type
 IPrismSession = Prism.Interfaces.IPrismSession;
 TSessionChangeType = Prism.Types.TSessionChangeType;
 TD2BridgeLang = D2Bridge.Types.TD2BridgeLang;


type
 TExemploLoginPWAWebAppGlobal = class(TD2BridgeServerControllerBase)
  private
   procedure OnNewSession(const Request: TPrismHTTPRequest; Response: TPrismHTTPResponse; Session: TPrismSession);
   procedure OnCloseSession(Session: TPrismSession);
   procedure OnDisconnectSession(Session: TPrismSession);
   procedure OnReconnectSession(Session: TPrismSession);
   procedure OnExpiredSession(Session: TPrismSession; var Renew: boolean);
   procedure OnIdleSession(Session: TPrismSession; var Renew: boolean);
   procedure OnException(Form: TObject; Sender: TObject; E: Exception; FormName: String; ComponentName: String; EventName: string; APrismSession: IPrismSession);
  public
   constructor Create(AOwner: TComponent); override;

 end;


var
 D2BridgeServerController: TExemploLoginPWAWebAppGlobal;


Function ExemploLoginPWA: TExemploLoginPWASession;


implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

Uses
 D2Bridge.Instance;

{$R *.dfm}

Function ExemploLoginPWA: TExemploLoginPWASession;
begin
 Result:= TExemploLoginPWASession(D2BridgeInstance.PrismSession.Data);
end;

constructor TExemploLoginPWAWebAppGlobal.Create(AOwner: TComponent);
begin
 inherited;
 {$IFDEF D2BRIDGE} 
  Prism.OnNewSession:= OnNewSession;
  Prism.OnCloseSession:= OnCloseSession;
  Prism.OnDisconnectSession:= OnDisconnectSession;
  Prism.OnReconnectSession:= OnReconnectSession;
  Prism.OnExpiredSession:= OnExpiredSession;
  Prism.OnIdleSession:= OnIdleSession;
  Prism.OnException:= OnException;
 {$ENDIF}

 
 //Our Code
 
  
 {$IFNDEF D2BRIDGE}
  OnNewSession(nil, nil, D2BridgeInstance.PrismSession as TPrismSession);
 {$ENDIF}
end;

procedure TExemploLoginPWAWebAppGlobal.OnException(Form, Sender: TObject; E: Exception; FormName, ComponentName, EventName: string; APrismSession: IPrismSession);
begin
 //Show Error Messages
 {
 if Assigned(APrismSession) then
   APrismSession.MessageDlg(E.Message, TMsgDlgType.mtError, [TMsgDlgBtn.mbok], 0);
 }
end;

procedure TExemploLoginPWAWebAppGlobal.OnNewSession(const Request: TPrismHTTPRequest; Response: TPrismHTTPResponse; Session: TPrismSession);
begin
 D2BridgeInstance.PrismSession.Data := TExemploLoginPWASession.Create(Session);

 //Set Language just this Session
 //Session.Language:= TD2BridgeLang.English;

 //Our Code

end;

procedure TExemploLoginPWAWebAppGlobal.OnCloseSession(Session: TPrismSession);
begin
 //Close ALL DataBase connection
 //Ex: Dm.DBConnection.Close;

end;

procedure TExemploLoginPWAWebAppGlobal.OnExpiredSession(Session: TPrismSession; var Renew: boolean);
begin
 //Example of use Renew
 {
  if Session.InfoConnection.Identity = 'UserXYZ' then
   Renew:= true;
 }
end;

procedure TExemploLoginPWAWebAppGlobal.OnIdleSession(Session: TPrismSession; var Renew: boolean);
begin

end;

procedure TExemploLoginPWAWebAppGlobal.OnDisconnectSession(Session: TPrismSession);
begin

end;

procedure TExemploLoginPWAWebAppGlobal.OnReconnectSession(Session: TPrismSession);
begin

end;


{$IFNDEF D2BRIDGE}
initialization
 D2BridgeServerController:= TExemploLoginPWAWebAppGlobal.Create(D2BridgeInstance.Owner);
{$ENDIF}

end.
