object Form22: TForm22
  Left = 0
  Top = 0
  Caption = 'Form22'
  ClientHeight = 242
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    472
    242)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 128
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 209
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 1
    OnClick = Button2Click
  end
  object TabControl1: TTabControl
    Left = 8
    Top = 39
    Width = 456
    Height = 193
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
    OnChange = TabControl1Change
    object SheetData: TDrawGrid
      Left = 4
      Top = 6
      Width = 448
      Height = 183
      Align = alClient
      TabOrder = 0
      OnDrawCell = SheetDataDrawCell
      ExplicitLeft = 72
      ExplicitTop = 40
      ExplicitWidth = 320
      ExplicitHeight = 120
    end
  end
  object cbXlsx: TCheckBox
    Left = 8
    Top = 8
    Width = 97
    Height = 17
    Caption = 'xlsx'
    TabOrder = 3
  end
end
