unit UNiceDelphi;

interface

uses
  System.SysUtils;

function int(num: string): integer;
function str(str: integer): string;
function len(str: string): integer;

implementation

function int(num: string): integer;
begin
  result := strtoint(num);
end;

function str(str: integer): string;
begin
  result := inttostr(str);
end;

function len(str: string): integer;
begin
  result := length(str);
end;

end.
