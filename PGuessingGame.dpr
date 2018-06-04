program PGuessingGame;

uses
  Vcl.Forms,
  UNiceDelphi in 'UNiceDelphi.pas',
  UInterface in 'UInterface.pas' {UI};
{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TUI, UI);
  Application.Run;
end.
