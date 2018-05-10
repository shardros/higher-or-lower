unit UNiceDelphi;

interface

  uses
    System.SysUtils;

  function int(num: string): integer;
  function str(str: integer): string;

implementation

  function int(num: string): integer;
  begin
    result := strtoint(num);
  end;

  function str(str: integer): string;
  begin
    result := inttostr(str);
  end;
end.
