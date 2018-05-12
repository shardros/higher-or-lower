program PGuessingGame;

uses
  Vcl.Forms,
  UNiceDelphi in 'UNiceDelphi.pas',
  UInterface in 'UInterface.pas' {UI},
  UHigherLowerMouseGame in 'UHigherLowerMouseGame.pas' {MouseGame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TUI, UI);
  Application.CreateForm(TMouseGame, MouseGame);
  Application.Run;
end.
