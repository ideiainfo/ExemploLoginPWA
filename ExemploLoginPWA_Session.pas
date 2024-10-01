unit ExemploLoginPWA_Session;

interface

uses
  System.SysUtils, System.Classes,
  Prism.SessionBase;

type
  TExemploLoginPWASession = class(TPrismSessionBase)
  private

  public
   constructor Create(APrismSession: TPrismSession); override;  //OnNewSession
   destructor Destroy; override; //OnCloseSession
  end;


implementation

Uses
  D2Bridge.Instance,
  ExemploLoginPWAWebApp;

{$R *.dfm}

constructor TExemploLoginPWASession.Create(APrismSession: TPrismSession); //OnNewSession
begin
 inherited;

 //Your code

end;

destructor TExemploLoginPWASession.Destroy; //OnCloseSession
begin
 //Close ALL DataBase connection
 //Ex: Dm.DBConnection.Close;

 inherited;
end;

end.

