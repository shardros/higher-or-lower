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
    test1: TMenuItem;
    test2: TMenuItem;
    test3: TMenuItem;
    testes1: TMenuItem;
    guessInstruction: TLabel;
    log: TListBox;
    SelectorHuman: TCheckBox;
    SelectorComputer: TCheckBox;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure UsersGuessKeyPress(Sender: TObject; var Key: char);
    procedure SelectorHumanClick(Sender: TObject);
    procedure SelectorComputerClick(Sender: TObject);
    procedure GuessButtonClick(Sender: TObject);
  private
    ActualNumber: integer;
    RemainingGuesses: integer;
    function processGuess(Guess: integer; Actual: integer): string;
    procedure ProcessUserGuess;
    procedure RemoveGuess;
    procedure EndGame;
    function manualGuessing: boolean;
    procedure processComputerGuess;
  public
    procedure NewGame;
  end;

var
  UI: TUI;

implementation

{$R *.dfm}

function TUI.manualGuessing: boolean;
begin
  if SelectorHuman.Checked xor SelectorComputer.Checked then
    result := SelectorHuman.Checked;

end;

{
  I couldn't find any useful documentation on how to make the radio buttons work
  so I made my own radio buttons out of check boxes and a script to make them
  muturally exclusive. I am aware that it is possible for the user to select no
  mode.
}
procedure TUI.SelectorComputerClick(Sender: TObject);
begin
  if SelectorComputer.Checked and SelectorHuman.Checked then
  begin
    SelectorComputer.Checked := false;
    SelectorHuman.Checked := false;
    SelectorComputer.Checked := True;
    NewGame; {
      Start a new game even if the user is halfway through a game to avoid weirdness
      NewGame only needs to be called here because this is always called when the
      user interacts with the buttons, with the exception of when they deselect both }
  end
  else
  begin
    if not(SelectorComputer.Checked) and SelectorHuman.Checked then
    begin
      SelectorHuman.Checked := false;
      SelectorComputer.Checked := True;
    end;
  end;

end;

procedure TUI.SelectorHumanClick(Sender: TObject);
// See above for comments
begin
  if SelectorComputer.Checked and SelectorHuman.Checked then
  begin
    SelectorHuman.Checked := false;
    SelectorComputer.Checked := false;
    SelectorHuman.Checked := True;
    NewGame;
  end
  else
  begin
    if not(SelectorHuman.Checked) and SelectorComputer.Checked then
    begin
      SelectorComputer.Checked := false;
      SelectorHuman.Checked := True;
    end;
  end;
end;

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
  if manualGuessing then
    ProcessUserGuess
  else
    processComputerGuess;

end;

procedure TUI.NewGame;
{
  Resets all the parmeters to how they should be a the start
  of a game.
}
begin
  if manualGuessing then
  begin
    log.Items.Add('Manual mode selected');
    ActualNumber := random(100);

    RemainingGuesses := 7;
    RemainingGuessesLabel.Visible := True;
    RemainingGuessesLabel.Caption :=
      ('Remaining Guesses: ' + str(RemainingGuesses));

    log.Items.Add('Guess the number between 0-100');

    GuessButton.Enabled := True;
    GuessButton.Caption := 'Guess!';
    UsersGuess.Enabled := True;

  end
  else
  begin // We are in computer guessing mode
    log.Items.Add('Computer mode selected');
    GuessButton.Enabled := True;
    GuessButton.Caption := 'Enter';

    UsersGuess.Enabled := True;
    RemainingGuessesLabel.Visible := false;
  end;
end;

procedure TUI.processComputerGuess;
var
  Actual, Guess, oldGuess, newGuess: integer;
  higherOrLower: integer;
begin
  if len(UsersGuess.Text) > 0 then
  { I have to allow the input key to be a valid key but this means
    that it is possible to press enter really fast and cause
    the enter key to atempt to be converted to an integer }
  begin
    oldGuess := 0;
    Guess := 50;
    Actual := int(UsersGuess.Text);
    repeat
      log.Items.Add('The computer is guessing: ' + str(Guess));
      higherOrLower := int(processGuess(Guess, Actual));
      newGuess := abs(Guess - oldGuess) * higherOrLower + Guess;
      { This works out the next number in the binnary search }
      oldGuess := Guess;
      Guess := newGuess;
    until (higherOrLower = 0);
  end;
end;

function TUI.processGuess(Guess, Actual: integer): string;
begin
  if Guess > Actual then
    result := '1'
  else
  begin
    if Guess < Actual then
      result := '-1'
    else
      result := '0';
  end;
end;

procedure TUI.ProcessUserGuess;
{
  Processes Users Guess:
  ~Compares the number with the target
  ~Appends the relivent message to the log box
  ~Clears the input box
}
var
  Guess: integer;
begin
  if len(UsersGuess.Text) > 0 then
  { I have to allow the input key to be a valid key but this means
    that it is possible to press enter really fast and cause
    the enter key to atempt to be converted to an integer }
  begin
    Guess := int(UsersGuess.Text);
    case processGuess(Guess, ActualNumber)[1] of
      '1':
        begin
          log.Items.Add(str(Guess) + ' - Too High');
          RemoveGuess;
        end;
      '-':
        begin
          log.Items.Add(str(Guess) + ' - Too Low');
          RemoveGuess;
        end;
      '0':
        begin
          log.Items.Add(str(Guess) + ' - You got it right!');
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
    GuessButton.Enabled := false;
    UsersGuess.Enabled := false;
    showmessage('You ran out of guesses D: Starting new game...');
    NewGame;
  end;
end;

procedure TUI.UsersGuessKeyPress(Sender: TObject; var Key: char);
{
  Handles input sanitization
  Enter - Process users guess
  Valid interger or delete - allow
  All other keys are set to null
}
begin
  if Key = #13 then
  begin // #13 = Enter
    if manualGuessing then
      ProcessUserGuess
    else
      processComputerGuess;
  end
  else
  begin
    if not(Key in [#8, '0' .. '9']) then // #8 Delete
      Key := #0; // #0 is null
  end;
end;

end.
