unit UInterface;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus,
  UNiceDelphi, Vcl.ComCtrls;

type
  TUI = class(TForm)
    GuessButton: TButton;
    UsersGuess: TEdit;
    RemainingGuessesLabel: TLabel;
    PastGuesses: TLabel;
    MainMenu1: TMainMenu;
    ModeSelector: TRadioGroup;
    test1: TMenuItem;
    test2: TMenuItem;
    test3: TMenuItem;
    testes1: TMenuItem;
    Label1: TLabel;
    History: TListBox;
    procedure GuessButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UsersGuessKeyPress(Sender: TObject; var Key: Char);


  private
    ActualNumber: integer;
    RemainingGuesses: integer;
    procedure ProcessUserGuess;
    procedure RemoveGuess;
    procedure EndGame;
  public
    procedure NewGame;
  end;

var
  UI: TUI;

implementation

{$R *.dfm}

procedure TUI.EndGame;
begin
  showmessage('Well done! You guessed it right; starting a new game...');
  NewGame;
end;

procedure TUI.FormCreate(Sender: TObject);
begin
  randomize;
  NewGame;
end;

procedure TUI.GuessButtonClick(Sender: TObject);
begin
  ProcessUserGuess;
end;

procedure TUI.NewGame;
{
  Resets all the parmeters to how they should be a the start
  of a game
}
begin
  ActualNumber := random(100);
  RemainingGuesses := 7;
  RemainingGuessesLabel.Caption :=
    ('Remaining Guesses: ' + str(RemainingGuesses));
  History.Items.Add('Guess the number between 0-100');
  GuessButton.Enabled := True;
  UsersGuess.Enabled := True;
end;

procedure TUI.ProcessUserGuess;
{
  Processes Users Guess:
  ~Compares the number with the target
  ~Appends the relivent message to the history box
  ~Clears the input box
}
var
  guess: integer;
begin
  if len(UsersGuess.Text) > 0 then
  { I have to allow the input key to be a valid key but this means
    that it is possible to press enter really fast and cause
    the enter key to atempt to be converted to an integer }
  begin
    guess := int(UsersGuess.Text);
    if guess > ActualNumber then
    begin
      History.Items.Add(str(guess) + ' - Too High');
      RemoveGuess;
    end
    else
    begin
      if guess < ActualNumber then
      begin
        History.Items.Add(str(guess) + ' - Too Low');
        RemoveGuess;
      end
      else begin
        History.Items.Add(str(guess) + ' - You got it right!');
        EndGame;
      end;
    end;
    UsersGuess.Text := '';
  end;
end;

procedure TUI.RemoveGuess;
{
  Decrements the Remaining guesses
  if zero remaining disable functionality of button and enterbox
  Updates remaining guess counter.
}
begin
  dec(RemainingGuesses);
  RemainingGuessesLabel.Caption :=
    ('Remaining Guesses: ' + str(RemainingGuesses));
  if RemainingGuesses = 0 then
  begin
    GuessButton.Enabled := False;
    UsersGuess.Enabled := False;
    showmessage('You ran out of guesses D: Starting new game...');
    NewGame;
  end;
end;

procedure TUI.UsersGuessKeyPress(Sender: TObject; var Key: Char);
{
  Handles input sanitization
  Enter - Process users guess
  Valid interger or delete - allow
  All other keys are set to null
}
begin
  if Key = #13 then
  begin // #13 = Enter
    ProcessUserGuess;
  end
  else
  begin
    if not(Key in [#8, '0' .. '9']) then // #8 Delete
      Key := #0; // #0 is null
  end;
end;

end.
