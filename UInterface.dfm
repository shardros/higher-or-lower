object UI: TUI
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'UI'
  ClientHeight = 313
  ClientWidth = 453
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RemainingGuessesLabel: TLabel
    Left = 248
    Top = 8
    Width = 148
    Height = 19
    Caption = 'Remaining Guesses: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object PastGuesses: TLabel
    Left = 16
    Top = 8
    Width = 91
    Height = 19
    Caption = 'Past Guesses'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 256
    Top = 168
    Width = 87
    Height = 13
    Caption = 'Enter Your Guess:'
  end
  object GuessButton: TButton
    Left = 248
    Top = 227
    Width = 185
    Height = 69
    Caption = 'Guess!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = GuessButtonClick
  end
  object UsersGuess: TEdit
    Left = 248
    Top = 192
    Width = 185
    Height = 21
    TabOrder = 1
    OnKeyPress = UsersGuessKeyPress
  end
  object ModeSelector: TRadioGroup
    Left = 248
    Top = 33
    Width = 185
    Height = 112
    Caption = 'ModeSelector'
    Items.Strings = (
      'Computer'
      'Human')
    TabOrder = 2
  end
  object History: TListBox
    Left = 16
    Top = 33
    Width = 201
    Height = 263
    ItemHeight = 13
    TabOrder = 3
  end
  object MainMenu1: TMainMenu
    Left = 448
    Top = 16
    object test1: TMenuItem
      Caption = 'Menu'
      object test2: TMenuItem
        Caption = 'New Game'
      end
      object test3: TMenuItem
        Caption = 'Save Game'
      end
      object testes1: TMenuItem
        Caption = 'Save Game As'
      end
    end
  end
end
