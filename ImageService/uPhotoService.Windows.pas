unit uPhotoService.Windows;

interface

uses
  uPhotoServiceInterface, System.SysUtils, FMX.Graphics;

type

TWindowsPhotoService = class(TInterfacedObject,IPhotoService)
protected
  FPhotoTakenOrPicked: TProc<TBitmap>;
public
  procedure TakePhoto;
  procedure PickPhoto;
  function GetPhotoTaken: TProc<TBitmap>;
  procedure SetPhotoTaken(Value: TProc<TBitmap>);
  property OnPhotoTakenOrPicked: TProc<TBitmap> read GetPhotoTaken write SetPhotoTaken;

  constructor Create;
  destructor Destroy; override;
end;

implementation

uses
  FMX.Dialogs;

{ TWindowsPhotoService }

constructor TWindowsPhotoService.Create;
begin

end;

destructor TWindowsPhotoService.Destroy;
begin

  inherited;
end;

function TWindowsPhotoService.GetPhotoTaken: TProc<TBitmap>;
begin
  Result := FPhotoTakenOrPicked;
end;

procedure TWindowsPhotoService.PickPhoto;
var
  dialog: TOpenDialog;
  bitmap: TBitmap;
begin
    dialog := TOpenDialog.Create(nil);
    try
      dialog.Filter := 'JPG files |*.jpg';

      if dialog.Execute then
      begin

        if Assigned(FPhotoTakenOrPicked) then
        begin
          bitmap := TBitmap.Create;
          bitmap.LoadFromFile(dialog.FileName);
          FPhotoTakenOrPicked(bitmap);
        end;

      end;

    finally
      dialog.Free;
    end;

end;

procedure TWindowsPhotoService.SetPhotoTaken(Value: TProc<TBitmap>);
begin
  FPhotoTakenOrPicked := Value;
end;

procedure TWindowsPhotoService.TakePhoto;
begin
  PickPhoto;
end;

end.
