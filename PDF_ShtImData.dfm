object fmSheetImport: TfmSheetImport
  Left = 0
  Top = 0
  ActiveControl = bbImport
  Caption = 'Import data from Excel spreadsheet'
  ClientHeight = 839
  ClientWidth = 878
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDefaultSizeOnly
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 524
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
    object lShowOnly50Rows: TLabel
      Left = 716
      Top = 14
      Width = 145
      Height = 13
      Alignment = taRightJustify
      Caption = 'Showing only the first 50 rows'
    end
    object bbOpenSheet: TBitBtn
      Left = 114
      Top = 2
      Width = 75
      Height = 25
      Hint = 'Select spread sheet'
      Caption = '&Open'
      ImageIndex = 27
      ImageName = 'Trayse101-Basic-Filetypes-2'
      Images = VirtualImageList1
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
      ImageIndex = 10
      ImageName = 'stop'
      Images = VirtualImageList1
      ModalResult = 2
      TabOrder = 1
      OnClick = bbCancelClick
    end
  end
  object pDefinitions: TPanel
    Left = 0
    Top = 536
    Width = 878
    Height = 284
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object gbDefineFields: TGroupBox
      Left = 0
      Top = 74
      Width = 878
      Height = 210
      Hint = 'Specify column letter or 0 (zero) to omit.'
      Align = alBottom
      Caption = 'Define fields'
      TabOrder = 0
      object Label9: TLabel
        Left = 696
        Top = 128
        Width = 71
        Height = 13
        Caption = 'Minimum Sigma'
        Visible = False
      end
      object Label12: TLabel
        Left = 776
        Top = 128
        Width = 99
        Height = 13
        Caption = 'Extra variable cutoff'
        Visible = False
      end
      object Panel1: TPanel
        Left = 2
        Top = 15
        Width = 688
        Height = 193
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object Label5: TLabel
          Left = 8
          Top = 4
          Width = 88
          Height = 13
          Caption = 'Data (age) column'
        end
        object Label1: TLabel
          Left = 8
          Top = 30
          Width = 92
          Height = 13
          Caption = 'Uncertainty column'
        end
        object Label6: TLabel
          Left = 192
          Top = 30
          Width = 357
          Height = 13
          Caption = 
            'uncertainties must be absolute 1 sigma, 2 sigma or 95% confidenc' +
            'e values'
        end
        object Label7: TLabel
          Left = 8
          Top = 56
          Width = 107
          Height = 13
          Caption = 'Deposition age column'
        end
        object Label8: TLabel
          Left = 192
          Top = 56
          Width = 362
          Height = 13
          Caption = 
            'only needed to construct multiple probability vertcal view plots' +
            ' (0 to ignore)'
        end
        object Label10: TLabel
          Left = 8
          Top = 82
          Width = 103
          Height = 13
          Caption = 'Extra variable column'
        end
        object Label11: TLabel
          Left = 192
          Top = 82
          Width = 473
          Height = 13
          Caption = 
            'only needed to overlay extra variable values on multi-plot or fo' +
            'r commodity weighting (0 to ignore)'
        end
        object Label16: TLabel
          Left = 8
          Top = 109
          Width = 47
          Height = 13
          Caption = 'SampleNo'
        end
        object Label17: TLabel
          Left = 192
          Top = 109
          Width = 60
          Height = 13
          Caption = '(0 to ignore)'
        end
        object Label19: TLabel
          Left = 8
          Top = 136
          Width = 21
          Height = 13
          Caption = 'Frac'
        end
        object Label20: TLabel
          Left = 192
          Top = 136
          Width = 60
          Height = 13
          Caption = '(0 to ignore)'
        end
        object Label13: TLabel
          Left = 8
          Top = 163
          Width = 54
          Height = 13
          Caption = 'Association'
        end
        object Label14: TLabel
          Left = 192
          Top = 163
          Width = 60
          Height = 13
          Caption = '(0 to ignore)'
        end
        object eDataColStr: TEdit
          Left = 136
          Top = 0
          Width = 41
          Height = 21
          TabOrder = 0
        end
        object eSigmaColStr: TEdit
          Left = 136
          Top = 26
          Width = 41
          Height = 21
          TabOrder = 1
        end
        object eUnitAgeColStr: TEdit
          Left = 136
          Top = 52
          Width = 41
          Height = 21
          TabOrder = 2
        end
        object eExtraVarColStr: TEdit
          Left = 136
          Top = 78
          Width = 41
          Height = 21
          TabOrder = 3
        end
        object eSampleNoColStr: TEdit
          Left = 136
          Top = 105
          Width = 41
          Height = 21
          TabOrder = 4
        end
        object eFracColStr: TEdit
          Left = 136
          Top = 132
          Width = 41
          Height = 21
          TabOrder = 5
        end
        object eAssocColStr: TEdit
          Left = 136
          Top = 159
          Width = 41
          Height = 21
          TabOrder = 6
        end
      end
      object rgUncertainties: TRadioGroup
        Left = 696
        Top = 12
        Width = 100
        Height = 105
        Caption = 'Uncertainties'
        ItemIndex = 0
        Items.Strings = (
          '1 sigma'
          '2 sigma'
          '95% conf.')
        TabOrder = 1
        OnClick = rgUncertaintiesClick
      end
      object eDefaultMinimum: TEdit
        Left = 704
        Top = 144
        Width = 64
        Height = 21
        TabOrder = 2
        Text = '.1'
        Visible = False
      end
      object eExtraCutoff: TEdit
        Left = 776
        Top = 144
        Width = 64
        Height = 21
        TabOrder = 3
        Text = '0.1'
        Visible = False
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 6
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
        ImageIndex = 36
        ImageName = 'Gakuseisean-Ivista-2-Misc-Download'
        Images = VirtualImageList1
        ModalResult = 1
        NumGlyphs = 2
        TabOrder = 0
        OnClick = bbImportClick
      end
      object gbDefineRows: TGroupBox
        Left = 2
        Top = -15
        Width = 535
        Height = 77
        Caption = 'Define rows to import'
        TabOrder = 1
        object Label2: TLabel
          Left = 8
          Top = 36
          Width = 45
          Height = 13
          Caption = 'From row'
        end
        object Label3: TLabel
          Left = 128
          Top = 36
          Width = 33
          Height = 13
          Caption = 'To row'
        end
        object Label4: TLabel
          Left = 272
          Top = 28
          Width = 188
          Height = 13
          Alignment = taCenter
          Caption = 'All un-readable data will be set to zero.'
        end
        object sbFindLastRow: TSpeedButton
          Left = 229
          Top = 32
          Width = 23
          Height = 22
          Hint = 'Find end of data in file'
          ImageIndex = 19
          ImageName = 'filled_filter'
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = sbFindLastRowClick
        end
        object meFromRow: TEdit
          Left = 58
          Top = 32
          Width = 45
          Height = 21
          TabOrder = 0
          Text = '2'
        end
        object meToRow: TEdit
          Left = 168
          Top = 32
          Width = 45
          Height = 21
          TabOrder = 1
          Text = '3'
        end
        object cbOmitNegatives: TCheckBox
          Left = 272
          Top = 48
          Width = 137
          Height = 17
          Caption = 'Omit negative values'
          Checked = True
          State = cbChecked
          TabOrder = 2
          Visible = False
        end
      end
    end
  end
  object sbSheet: TStatusBar
    Left = 0
    Top = 820
    Width = 878
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object pData: TPanel
    Left = 0
    Top = 33
    Width = 878
    Height = 491
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object TabControl1: TTabControl
      Left = 0
      Top = 0
      Width = 878
      Height = 491
      Align = alClient
      TabOrder = 0
      TabPosition = tpBottom
      OnChange = TabControl1Change
      object SheetData: TDrawGrid
        Left = 4
        Top = 4
        Width = 870
        Height = 483
        Align = alClient
        Ctl3D = False
        DefaultRowHeight = 18
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goRowSizing, goColSizing, goThumbTracking]
        ParentCtl3D = False
        TabOrder = 0
        OnDrawCell = SheetDataDrawCell
        ColWidths = (
          64
          64
          64
          64
          64)
        RowHeights = (
          18
          18
          18
          18
          18)
      end
    end
  end
  object OpenDialogSprdSheet: TOpenDialog
    DefaultExt = '.XLSX'
    Filter = 
      'Excel files|*.xls;*.xlsx;*.xlsm|Excel 2013|*.XLSX|Excel 97 - 200' +
      '3|*.XLS|Excel XML|*.XLSM'
    Options = [ofShowHelp, ofExtensionDifferent, ofPathMustExist, ofFileMustExist, ofShareAware]
    Left = 332
    Top = 4
  end
  object VirtualImageList1: TVirtualImageList
    AutoFill = True
    DisabledGrayscale = True
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'open_document'
        Name = 'open_document'
      end
      item
        CollectionIndex = 1
        CollectionName = 'new_document_lined'
        Name = 'new_document_lined'
      end
      item
        CollectionIndex = 2
        CollectionName = 'print'
        Name = 'print'
      end
      item
        CollectionIndex = 3
        CollectionName = 'save'
        Name = 'save'
      end
      item
        CollectionIndex = 4
        CollectionName = 'folder_closed'
        Name = 'folder_closed'
      end
      item
        CollectionIndex = 5
        CollectionName = 'cut_clipboard'
        Name = 'cut_clipboard'
      end
      item
        CollectionIndex = 6
        CollectionName = 'folder_open'
        Name = 'folder_open'
      end
      item
        CollectionIndex = 7
        CollectionName = 'move_to_folder'
        Name = 'move_to_folder'
      end
      item
        CollectionIndex = 8
        CollectionName = 'redo'
        Name = 'redo'
      end
      item
        CollectionIndex = 9
        CollectionName = 'delete'
        Name = 'delete'
      end
      item
        CollectionIndex = 10
        CollectionName = 'stop'
        Name = 'stop'
      end
      item
        CollectionIndex = 11
        CollectionName = 'home'
        Name = 'home'
      end
      item
        CollectionIndex = 12
        CollectionName = 'new_document'
        Name = 'new_document'
      end
      item
        CollectionIndex = 13
        CollectionName = 'history'
        Name = 'history'
      end
      item
        CollectionIndex = 14
        CollectionName = 'history_b1'
        Name = 'history_b1'
      end
      item
        CollectionIndex = 15
        CollectionName = 'copy_clipboard_lined'
        Name = 'copy_clipboard_lined'
      end
      item
        CollectionIndex = 16
        CollectionName = 'Cornmanthe3rd-Plex-System-recycling-bin'
        Name = 'Cornmanthe3rd-Plex-System-recycling-bin'
      end
      item
        CollectionIndex = 17
        CollectionName = 'Cornmanthe3rd-Plex-System'
        Name = 'Cornmanthe3rd-Plex-System'
      end
      item
        CollectionIndex = 18
        CollectionName = 'Cornmanthe3rd-Plex-Utilities'
        Name = 'Cornmanthe3rd-Plex-Utilities'
      end
      item
        CollectionIndex = 19
        CollectionName = 'Hamzasaleem-Stock-Folder-Big'
        Name = 'Hamzasaleem-Stock-Folder-Big'
      end
      item
        CollectionIndex = 20
        CollectionName = 'Hopstarter-Sleek-Xp-Basic'
        Name = 'Hopstarter-Sleek-Xp-Basic'
      end
      item
        CollectionIndex = 21
        CollectionName = 'img.icons8'
        Name = 'img.icons8'
      end
      item
        CollectionIndex = 22
        CollectionName = 'Kyo-Tux-Phuzion-Device'
        Name = 'Kyo-Tux-Phuzion-Device'
      end
      item
        CollectionIndex = 23
        CollectionName = 'Kyo-Tux-Phuzion-Misc'
        Name = 'Kyo-Tux-Phuzion-Misc'
      end
      item
        CollectionIndex = 24
        CollectionName = 'Kyo-Tux-Phuzion-Sign'
        Name = 'Kyo-Tux-Phuzion-Sign'
      end
      item
        CollectionIndex = 25
        CollectionName = 'Kyo-Tux-Phuzion-System'
        Name = 'Kyo-Tux-Phuzion-System'
      end
      item
        CollectionIndex = 26
        CollectionName = 'Rskys-Windows-Business'
        Name = 'Rskys-Windows-Business'
      end
      item
        CollectionIndex = 27
        CollectionName = 'Trayse101-Basic-Filetypes-2'
        Name = 'Trayse101-Basic-Filetypes-2'
      end
      item
        CollectionIndex = 28
        CollectionName = 'Aha-Soft-Free-3d-Glossy-Interface'
        Name = 'Aha-Soft-Free-3d-Glossy-Interface'
      end
      item
        CollectionIndex = 29
        CollectionName = 'Ampeross-Ampola-Folder'
        Name = 'Ampeross-Ampola-Folder'
      end
      item
        CollectionIndex = 30
        CollectionName = 'Custom-Icon-Design-Pretty-Office-9-Open'
        Name = 'Custom-Icon-Design-Pretty-Office-9-Open'
      end
      item
        CollectionIndex = 31
        CollectionName = 'Double-J-Design-Ravenna-3d-Database'
        Name = 'Double-J-Design-Ravenna-3d-Database'
      end
      item
        CollectionIndex = 32
        CollectionName = 'Fasticon-Database-Table'
        Name = 'Fasticon-Database-Table'
      end
      item
        CollectionIndex = 33
        CollectionName = 'Fasticon-Database'
        Name = 'Fasticon-Database'
      end
      item
        CollectionIndex = 34
        CollectionName = 'Flat-Icons.com-Square'
        Name = 'Flat-Icons.com-Square'
      end
      item
        CollectionIndex = 35
        CollectionName = 'Flat-Icons.com-Square-Graph'
        Name = 'Flat-Icons.com-Square-Graph'
      end
      item
        CollectionIndex = 36
        CollectionName = 'Gakuseisean-Ivista-2-Misc-Download'
        Name = 'Gakuseisean-Ivista-2-Misc-Download'
      end
      item
        CollectionIndex = 37
        CollectionName = 'Gakuseisean-Ivista-2-Misc-New'
        Name = 'Gakuseisean-Ivista-2-Misc-New'
      end
      item
        CollectionIndex = 38
        CollectionName = 'Gakuseisean-Ivista-2-Misc-Web'
        Name = 'Gakuseisean-Ivista-2-Misc-Web'
      end
      item
        CollectionIndex = 39
        CollectionName = 'Gartoon-Team-Gartoon-Apps-Gnome-power'
        Name = 'Gartoon-Team-Gartoon-Apps-Gnome-power'
      end
      item
        CollectionIndex = 40
        CollectionName = 'Gianni-Polito-Colobrush-System-database'
        Name = 'Gianni-Polito-Colobrush-System-database'
      end
      item
        CollectionIndex = 41
        CollectionName = 'Github-Octicons-Graph'
        Name = 'Github-Octicons-Graph'
      end
      item
        CollectionIndex = 42
        CollectionName = 'Graphicloads-Flat-Finance-World'
        Name = 'Graphicloads-Flat-Finance-World'
      end
      item
        CollectionIndex = 43
        CollectionName = 'Hopstarter-Mac-Folders'
        Name = 'Hopstarter-Mac-Folders'
      end
      item
        CollectionIndex = 44
        CollectionName = 'Hopstarter-Soft-Scraps-File'
        Name = 'Hopstarter-Soft-Scraps-File'
      end
      item
        CollectionIndex = 45
        CollectionName = 'Icojam-Blue-Bits-Database'
        Name = 'Icojam-Blue-Bits-Database'
      end
      item
        CollectionIndex = 46
        CollectionName = 'Icojam-Blue-Bits-Database-arrow'
        Name = 'Icojam-Blue-Bits-Database-arrow'
      end
      item
        CollectionIndex = 47
        CollectionName = 'Icons8-Ios7-Data-Area'
        Name = 'Icons8-Ios7-Data-Area'
      end
      item
        CollectionIndex = 48
        CollectionName = 'Icons8-Ios7-Data-Line'
        Name = 'Icons8-Ios7-Data-Line'
      end
      item
        CollectionIndex = 49
        CollectionName = 'Icons8-Ios7-Data-Scatter'
        Name = 'Icons8-Ios7-Data-Scatter'
      end
      item
        CollectionIndex = 50
        CollectionName = 'Iconsmind-Outline'
        Name = 'Iconsmind-Outline'
      end
      item
        CollectionIndex = 51
        CollectionName = 'Saki-Snowish-Mimetypes-gnome-mime-application-vnd-lotus-1-2'
        Name = 'Saki-Snowish-Mimetypes-gnome-mime-application-vnd-lotus-1-2'
      end
      item
        CollectionIndex = 52
        CollectionName = 'Tatice-Operating-Systems'
        Name = 'Tatice-Operating-Systems'
      end
      item
        CollectionIndex = 53
        CollectionName = 'Treetog-Junior-Document'
        Name = 'Treetog-Junior-Document'
      end
      item
        CollectionIndex = 54
        CollectionName = 'Custom-Icon-Design-Pretty-Office-2'
        Name = 'Custom-Icon-Design-Pretty-Office-2'
      end
      item
        CollectionIndex = 55
        CollectionName = 'Enhancedlabs-Longhorn-Pinstripe-Help'
        Name = 'Enhancedlabs-Longhorn-Pinstripe-Help'
      end
      item
        CollectionIndex = 56
        CollectionName = 'Hopstarter-Button-Button'
        Name = 'Hopstarter-Button-Button'
      end>
    ImageCollection = dmImageCollection.ImageCollection1
    Left = 488
  end
end
