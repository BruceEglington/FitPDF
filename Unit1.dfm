object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 621
  ClientWidth = 878
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 364
    Width = 878
    Height = 12
    Cursor = crVSplit
    Align = alBottom
    Beveled = True
    Color = clMoneyGreen
    ParentColor = False
    ExplicitLeft = -48
    ExplicitTop = 440
    ExplicitWidth = 926
  end
  object pControl: TPanel
    Left = 0
    Top = 0
    Width = 878
    Height = 33
    Align = alTop
    TabOrder = 0
    object bbOpenSheet: TBitBtn
      Left = 114
      Top = 2
      Width = 75
      Height = 25
      Hint = 'Select spread sheet'
      Caption = '&Open'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555555555555555555555555555555555555555555555555555555555555555
        555555555555555555555555555555555555555FFFFFFFFFF555550000000000
        55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
        B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
        000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
        555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
        55555575FFF75555555555700007555555555557777555555555555555555555
        5555555555555555555555555555555555555555555555555555}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbOpenSheetClick
    end
    object bbCancel: TBitBtn
      Left = 8
      Top = 4
      Width = 75
      Height = 25
      Caption = '&Cancel'
      TabOrder = 1
      OnClick = bbCancelClick
    end
  end
  object pDefinitions: TPanel
    Left = 0
    Top = 376
    Width = 878
    Height = 226
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object gbDefineFields: TGroupBox
      Left = 0
      Top = 73
      Width = 878
      Height = 153
      Hint = 'Specify column letter or 0 (zero) to omit.'
      Align = alBottom
      Caption = 'Define fields'
      TabOrder = 0
      object Label9: TLabel
        Left = 672
        Top = 32
        Width = 71
        Height = 13
        Caption = 'Minimum Sigma'
        Visible = False
      end
      object Panel1: TPanel
        Left = 2
        Top = 15
        Width = 511
        Height = 136
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object Label5: TLabel
          Left = 8
          Top = 28
          Width = 59
          Height = 13
          Caption = 'Data column'
        end
        object Label1: TLabel
          Left = 8
          Top = 64
          Width = 92
          Height = 13
          Caption = 'Uncertainty column'
        end
        object Label6: TLabel
          Left = 168
          Top = 64
          Width = 321
          Height = 13
          Caption = 
            '(uncertainties must be 1 sigma, 2 sigma or 95% confidence values' +
            ')'
        end
        object Label7: TLabel
          Left = 8
          Top = 100
          Width = 76
          Height = 13
          Caption = 'Unit age column'
        end
        object Label8: TLabel
          Left = 168
          Top = 100
          Width = 307
          Height = 13
          Caption = 
            '(only needed to construct multiple probability vertcal view plot' +
            's)'
        end
        object eDataColStr: TEdit
          Left = 112
          Top = 24
          Width = 41
          Height = 21
          TabOrder = 0
        end
        object eSigmaColStr: TEdit
          Left = 112
          Top = 60
          Width = 41
          Height = 21
          TabOrder = 1
        end
        object eUnitAgeColStr: TEdit
          Left = 112
          Top = 96
          Width = 41
          Height = 21
          TabOrder = 2
        end
      end
      object rgUncertainties: TRadioGroup
        Left = 519
        Top = 32
        Width = 100
        Height = 105
        Caption = 'Uncertainties'
        ItemIndex = 2
        Items.Strings = (
          '1 sigma'
          '2 sigma'
          '95% conf.')
        TabOrder = 1
        OnClick = rgUncertaintiesClick
      end
      object eDefaultMinimum: TEdit
        Left = 680
        Top = 52
        Width = 64
        Height = 21
        TabOrder = 2
        Text = '5.0'
        Visible = False
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 5
      Width = 878
      Height = 68
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object bbImport: TBitBtn
        Left = 672
        Top = 23
        Width = 109
        Height = 25
        Hint = 'Import selected data from spreadsheet'
        Caption = '&Import'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
          333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
          0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
          07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
          07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
          0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
          33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
          B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
          3BB33773333773333773B333333B3333333B7333333733333337}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = bbImportClick
      end
      object gbDefineRows: TGroupBox
        Left = 2
        Top = 1
        Width = 535
        Height = 65
        Caption = 'Define rows to import'
        TabOrder = 1
        object Label2: TLabel
          Left = 8
          Top = 20
          Width = 45
          Height = 13
          Caption = 'From row'
        end
        object Label3: TLabel
          Left = 128
          Top = 20
          Width = 33
          Height = 13
          Caption = 'To row'
        end
        object Label4: TLabel
          Left = 272
          Top = 12
          Width = 188
          Height = 13
          Alignment = taCenter
          Caption = 'All un-readable data will be set to zero.'
        end
        object sbFindLastRow: TSpeedButton
          Left = 228
          Top = 16
          Width = 23
          Height = 22
          Hint = 'Find end of file'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
            300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
            330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
            333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
            339977FF777777773377000BFB03333333337773FF733333333F333000333333
            3300333777333333337733333333333333003333333333333377333333333333
            333333333333333333FF33333333333330003333333333333777333333333333
            3000333333333333377733333333333333333333333333333333}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
        end
        object meFromRow: TEdit
          Left = 58
          Top = 16
          Width = 45
          Height = 21
          TabOrder = 0
          Text = '2'
        end
        object meToRow: TEdit
          Left = 168
          Top = 16
          Width = 45
          Height = 21
          TabOrder = 1
          Text = '3'
        end
        object cbOmitNegatives: TCheckBox
          Left = 272
          Top = 32
          Width = 137
          Height = 17
          Caption = 'Omit negative values'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
      end
    end
  end
  object sbSheet: TStatusBar
    Left = 0
    Top = 602
    Width = 878
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object pData: TPanel
    Left = 0
    Top = 33
    Width = 878
    Height = 331
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object SheetData: TDrawGrid
      Left = 0
      Top = 0
      Width = 878
      Height = 331
      Align = alClient
      Ctl3D = False
      DefaultRowHeight = 18
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goRowSizing, goColSizing, goThumbTracking]
      ParentCtl3D = False
      TabOrder = 0
      OnDrawCell = SheetDataDrawCell
    end
  end
  object OpenDialogSprdSheet: TOpenDialog
    DefaultExt = '.XLS'
    Filter = 
      'Excel files|*.xls;*.xlsx;*.xlsm|Excel 2007|*.XLSX|Excel 97 - 200' +
      '3|*.XLS|Excel XML|*.XLSM'
    Options = [ofShowHelp, ofExtensionDifferent, ofPathMustExist, ofFileMustExist, ofShareAware]
    Left = 332
    Top = 4
  end
end
