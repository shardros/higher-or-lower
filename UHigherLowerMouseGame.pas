unit UHigherLowerMouseGame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TMouseGame = class(TForm)
    ListBox1: TListBox;
  private
    procedure start;
  public
    { Public declarations }
  end;

var
  MouseGame: TMouseGame;

implementation

{$R *.dfm}

end.
