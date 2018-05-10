unit UInterface;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus, UNiceDelphi;

type
  TUI = class(TForm)
    GuessButton: TButton;
    UsersGuess: TEdit;
    RemainingGuesses: TLabel;
    PastGuesses: TLabel;
    History: TListBox;
    MainMenu1: TMainMenu;
    Mode: TRadioGroup;
    test1: TMenuItem;
    test2: TMenuItem;
    test3: TMenuItem;
    testes1: TMenuItem;
    procedure GuessButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    ActualNumber: integer;
  public
    procedure NewGame;
  end;

var
  UI: TUI;

implementation

{$R *.dfm}



procedure TUI.FormCreate(Sender: TObject);
begin
  randomize;
  NewGame;
end;

procedure TUI.GuessButtonClick(Sender: TObject);
var
  guess: integer;
begin
  guess := int(UsersGuess.Text);
  if guess > ActualNumber then
    History.Items.Add(str(guess) + ' - Too High')
  else begin
    if guess < ActualNumber then
      History.Items.Add(str(guess) + ' - Too Low')
    else
      History.Items.Add('You got it right!');
  end;
end;

procedure TUI.NewGame;
begin
  ActualNumber := random(100);
end;

end.
