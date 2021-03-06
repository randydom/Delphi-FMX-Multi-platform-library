unit uPhotoService.IOS;

interface

uses
    FMX.TMSNativeUIImagePickerController
  , FMX.MediaLibrary.Actions
  , uPhotoServiceInterface
  , System.SysUtils
  , FMX.Graphics
  , FMX.StdCtrls;

type

TIOSPhotoService = class(TInterfacedObject,IPhotoService)
protected
  FFakeBtn: TButton;
  FPhotoTakenOrPicked: TProc<TBitmap>;
  FTMSFMXNativeUIImagePickerController1: TTMSFMXNativeUIImagePickerController;
  FTakePhotoFromCameraAction: TTakePhotoFromCameraAction;
  procedure TMSFMXNativeUIImagePickerController1DidFinishPickingBitmap(Sender: TObject; aBitmap: TBitmap);
  procedure TakePhotoFromCameraActionDidFinishTaking(aBitmap: TBitmap);
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

{ TIOSPhotoService }

constructor TIOSPhotoService.Create;
begin
  FFakeBtn := TButton.Create(nil);

  FTMSFMXNativeUIImagePickerController1 := TTMSFMXNativeUIImagePickerController.Create(nil);
  FTMSFMXNativeUIImagePickerController1.OnDidFinishPickingBitmap := TMSFMXNativeUIImagePickerController1DidFinishPickingBitmap;
  //TMSFMXNativeUIImagePickerController1.OnDidCancel := IOSCAncelImagePicking;

  FTakePhotoFromCameraAction := TTakePhotoFromCameraAction.Create(FFakeBtn);
  FTakePhotoFromCameraAction.OnDidFinishTaking := TakePhotoFromCameraActionDidFinishTaking;
end;

destructor TIOSPhotoService.Destroy;
begin
  FTMSFMXNativeUIImagePickerController1.Free;
  FTakePhotoFromCameraAction.Free;
  FFakeBtn.Free;
  inherited;
end;

function TIOSPhotoService.GetPhotoTaken: TProc<TBitmap>;
begin
  Result := FPhotoTakenOrPicked;
end;

procedure TIOSPhotoService.PickPhoto;
begin
  FTMSFMXNativeUIImagePickerController1.Show;
end;

procedure TIOSPhotoService.SetPhotoTaken(Value: TProc<TBitmap>);
begin
  FPhotoTakenOrPicked := Value;
end;

procedure TIOSPhotoService.TakePhoto;
begin
  FTakePhotoFromCameraAction.ExecuteTarget(FFakeBtn);
end;

procedure TIOSPhotoService.TakePhotoFromCameraActionDidFinishTaking(
  aBitmap: TBitmap);
begin
  if Assigned(FPhotoTakenOrPicked) then
  begin
    FPhotoTakenOrPicked(aBitmap);
  end;
end;

procedure TIOSPhotoService.TMSFMXNativeUIImagePickerController1DidFinishPickingBitmap(
  Sender: TObject; aBitmap: TBitmap);
begin
  if Assigned(FPhotoTakenOrPicked) then
  begin
    FPhotoTakenOrPicked(aBitmap);
  end;
end;

end.
