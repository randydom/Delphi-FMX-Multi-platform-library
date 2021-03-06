unit uPhotoServiceInterface;

interface

uses
  System.SysUtils, FMX.Graphics;

type

IPhotoService = interface
  ['{83B303CF-6D35-4F95-850F-D468BC3CBFBD}']
  procedure TakePhoto;
  procedure PickPhoto;
  function GetPhotoTaken: TProc<TBitmap>;
  procedure SetPhotoTaken(Value: TProc<TBitmap>);
  property OnPhotoTakenOrPicked: TProc<TBitmap> read GetPhotoTaken write SetPhotoTaken;
end;

implementation


end.
