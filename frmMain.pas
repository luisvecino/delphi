unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, Data.DB, MemDS, DBAccess, Ora, OraCall, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, Vcl.DBCtrls;

type
  TfrmCurso = class(TForm)
    MainMenu1: TMainMenu;
    actAcciones: TActionList;
    actEmpleados: TAction;
    actNotas: TAction;
    mnManagement: TMenuItem;
    mnEmpleados: TMenuItem;
    mnNotas: TMenuItem;
    osOracle: TOraSession;
    lblResultado: TLabel;
    btnLLamada: TButton;
    dsPrueba: TDataSource;
    spEmpleados: TOraStoredProc;
    dbg1: TDBGrid;
    spHola: TOraStoredProc;
    btnListadoEmpleados: TSpeedButton;
    btnNotas: TSpeedButton;
    spSueldoJorge: TOraStoredProc;
    edt1: TEdit;
    edt2: TEdit;
    lista: TDBListBox;
    dsSueldoJorje: TDataSource;
    SuledoJorge: TLabel;
    btnSueldoJorge: TButton;
    procedure actExecute(Sender: TObject);
    procedure btnLLamadaClick(Sender: TObject);
    procedure lblResultadoClick(Sender: TObject);
    procedure dsPruebaDataChange(Sender: TObject; Field: TField);
    procedure btnSueldoJorgeClick(Sender: TObject);



  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCurso: TfrmCurso;



implementation

{$R *.dfm}



procedure TfrmCurso.actExecute(Sender: TObject);
  var
    sForma : String;
    FormClass : TFormClass;
   begin

    sForma := StringReplace(TAction(Sender).Name, 'act', 'frm', []);
    FormClass := TFormClass(GetClass('T' + sForma));
    if Assigned (FormClass) then
    with FormClass.Create(Self) do
    try   ShowModal;
    finally
      Free;
    end;


   end;



  {
   // LLamada a una función con parámetros  mayor entre
   begin

      procMayorEntre.Execute;

      lblResultado.caption := oraSes1.ExecProc('mayor_entre',[4,3]);
   end;

    }



procedure TfrmCurso.btnLLamadaClick(Sender: TObject);
var
  sueldo: string;
  nombre: string;
  i: Integer;
  registros:Integer;
begin
                spEmpleados.Active := True;
                // Contar el número de registros en la base de datos
                registros:= (dbg1.DataSource.DataSet.RecordCount) - 1;
//                registros := 9;

               for I := 0 to registros do
                 begin
                    if  spEmpleados.eof then
                    spEmpleados.First;
                      lista.Items.Strings[i]:= spEmpleados.FieldByName('nombre').Value;
                    spEmpleados.next;
                 end;
                  btnLLamada.Enabled := FALSE;
              while  not spEmpleados.eof do  // Si hay registros y no hemos llegado al último...

                     spEmpleados.First;

              begin
                        // En una lista
//                        lista.Items.Strings[0]:= spEmpleados.FieldByName('nombre').Value;
//                        lista.Items.Strings[1]:= spEmpleados.FieldByName('salario').Value;
                      edt1.Text := spEmpleados.FieldByName('nombre').Value;
 //                     edt2.text:= spEmpleados.FieldByName('salario').Value;

                      nombre:= edt1.Text;
                      spEmpleados.Next;

             end;

            // spEmpleados.ParamByName('CURSOR_EMPLEADOS');
//            spSueldoJorge.Execute;
//           sueldo :=  IntToStr(spSueldoJorge.ParamByName('sueldo').Value);
//           lblResultado.Caption:= sueldo;
end;


procedure TfrmCurso.btnSueldoJorgeClick(Sender: TObject);
var
  sueldo : string;
begin
  spSueldoJorge.Execute;
  edt2.Text := spSueldoJorge.ParamByName('sueldo').AsString;
  sueldo := edt2.Text;
  ShowMessage(sueldo);
end;

procedure TfrmCurso.dsPruebaDataChange(Sender: TObject; Field: TField);
begin

end;

{
procedure TfrmCurso.lblResultadoClick(Sender: TObject);
begin
  spHola.Execute;
  lblResultado.Caption:=spHola.ParamByName('saludo').AsString;
end;
}

procedure TfrmCurso.lblResultadoClick(Sender: TObject);
begin
  spHola.Execute;
  lblResultado.Caption:= spHola.ParamByName('saludo').AsString;
end;



end.
