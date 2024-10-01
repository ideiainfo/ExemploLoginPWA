unit Unit_Camera;

{ Copyright 2024 / 2025 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, 
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  D2Bridge.Forms, Vcl.ExtCtrls, Vcl.Imaging.jpeg, unit1;

type
  TForm_Camera = class(TForm1)
    Panel1: TPanel;
    Panel2: TPanel;
    Image1: TImage;
    imagetakephoto: TImage;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function Form_Camera:TForm_Camera;

implementation

Uses
  ExemploLoginPWAWebApp;

{$R *.dfm}

function Form_Camera:TForm_Camera;
begin
  result:= TForm_Camera(TForm_Camera.GetInstance);
end;

procedure TForm_Camera.Button1Click(Sender: TObject);
begin
  PrismSession.ExecJS('useCamera()');
end;

procedure TForm_Camera.Button2Click(Sender: TObject);
begin
  PrismSession.ExecJS('takePhoto()');
end;

procedure TForm_Camera.ExportD2Bridge;
begin
  inherited;

  Title:= 'My D2Bridge Form';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  with D2Bridge.Items.add do
  begin
    with Row.Items.Add do
    begin
        with PanelGroup('Câmera', '', false, CSSClass.Col.colsize4).Items.Add do
        begin
            with Row.Items.Add do
               HTMLElement('<video autoplay width="250em" id="VIDEOPLAY">');
            with HTMLDIV(CSSClass.DivHtml.Align_Center).Items.Add do
               VCLObj(Button1);
        end;

        with PanelGroup('Captura de Imagem', '', false, CSSClass.Col.colsize4).Items.Add do
          begin
            with Row.Items.Add do
                VCLObj(imagetakephoto);
            with HTMLDIV(CSSClass.DivHtml.Align_Center).Items.Add do
            begin
               VCLObj(Button2,  CSSClass.Button.save  );
               HTMLElement('<a download="foto.png" href="" id="LINKDOWNLOAD">Download</a>');
//               Link('Download da Foto','#','LINKDOWNLOAD','',NIL,'','','download="foto.png"');
            end;
        end;
    end;
  end;
  D2Bridge.HTML.Scripts.Add(memo1.Lines.Text);


end;

procedure TForm_Camera.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

 //Change Init Property of Prism Controls
 {
  if PrismControl.VCLComponent = Edit1 then
   PrismControl.AsEdit.DataType:= TPrismFieldType.PrismFieldTypeInteger;

  if PrismControl.IsDBGrid then
  begin
   PrismControl.AsDBGrid.RecordsPerPage:= 10;
   PrismControl.AsDBGrid.MaxRecords:= 2000;
  end;
 }
end;

procedure TForm_Camera.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
begin
 inherited;

 //Intercept HTML
 {
  if PrismControl.VCLComponent = Edit1 then
  begin
   HTMLControl:= '</>';
  end;
 }
end;

end.