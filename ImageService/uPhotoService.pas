unit uPhotoService;

interface

uses
  uPhotoServiceInterface, System.SysUtils, FMX.Graphics
  {$IFDEF IOS}
    ,uPhotoService.IOS
  {$ENDIF}
  {$IFDEF WIN32}
    ,uPhotoService.Windows
  {$ENDIF}
  {$IFDEF ANDROID}
    ,uPhotoService.Android
  {$ENDIF}
  ;

type

TPhotoService = class(TInterfacedObject,IPhotoService)
protected
  FDeviceSpecificService: IPhotoService;
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

{ TPhotoService }

constructor TPhotoService.Create;
begin
{$IFDEF IOS}
  FDeviceSpecificService := TIOSPhotoService.Create;
{$ENDIF}
{$IFDEF WIN32}
  FDeviceSpecificService := TWindowsPhotoService.Create;
{$ENDIF}
{$IFDEF ANDROID}
  FDeviceSpecificService := TAndroidPhotoService.Create;
{$ENDIF}
end;

destructor TPhotoService.Destroy;
begin
  FDeviceSpecificService := nil;
  inherited;
end;

function TPhotoService.GetPhotoTaken: TProc<TBitmap>;
begin
  Result := FDeviceSpecificService.OnPhotoTakenOrPicked;
end;

procedure TPhotoService.PickPhoto;
begin
  FDeviceSpecificService.PickPhoto;
end;

procedure TPhotoService.SetPhotoTaken(Value: TProc<TBitmap>);
begin
  FDeviceSpecificService.OnPhotoTakenOrPicked := Value;
end;

procedure TPhotoService.TakePhoto;
begin
  FDeviceSpecificService.TakePhoto;
end;

end.
