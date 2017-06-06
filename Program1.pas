uses
  crt;
type
  geo=record
    name:string[80];
    amount:int64;
    capacity:int64;
    man:int64;
    ship:string[64];
  end;
var
  geo_bd : file of geo;
  my_geo : geo;
  choice : integer;

procedure output_rec;
begin
  clrscr;
  writeln('������� ������������ ��������:');
  writeln('������������ ���������� ���������������� ��. �������   �����');
  reset(geo_bd);
  while not eof(geo_bd) do
    begin
      read(geo_bd,my_geo);
      with my_geo do
        begin
          write(name:5,' ');
          write(amount:15,' ');
          write(capacity:10,' ');
          write(man:18,' ');
          write(ship:10,' ');
        end;
      writeln;
    end;
  writeln('������� Enter ��� �������� � ������� ����.');
  readln;
  closefile(geo_bd);
end;
 
procedure append_rec;
begin
  clrscr;
  writeln('���������� ������ � ���� ������ "������������ ��������":');
  reset(geo_bd);
  with my_geo do
    begin
      write('�������� :');     readln(name);
      write('���������� :');    readln(amount);
      write('����������������,�� :'); readln(capacity);
      write('�������:');           readln(man);
      write('����� :');             readln(ship);
    end;
  seek(geo_bd,filesize(geo_bd));
  write(geo_bd,my_geo);
  writeln;
  writeln('������� Enter ��� �������� � ������� ����.');
  readln;
  closefile(geo_bd);
end;
 
procedure delete_rec;
var
  n,i : integer;
  s : String;
  t : geo;
begin
  clrscr;
  writeln('�������� ������ �� ���� ������ "������������ ��������":');
  write('������� �������� �����: '); readln(s);
  i:=0;
  n:=-maxint;
  Reset(geo_bd);
  while not eof (geo_bd) do
    begin
      read(geo_bd,t);
      inc(i);
      if t.ship=s then
        begin
          n:=i;
          break;
        end;
    end;
  if (filesize(geo_bd)<n) or (n<0) then
    begin
      writeln('� ����� ��� ����� ������');
      closefile(geo_bd);
      writeln;
      writeln('������� Enter ��� �������� � ������� ����.');
      readln;
      exit;
    end;
  seek(geo_bd,n-1);
  for i:=n-1 to filesize(geo_bd)-2 do
    begin
      seek(geo_bd,i+1);
      read(geo_bd,t);
      seek(geo_bd,i);
      write(geo_bd,t);
    end;
  seek(geo_bd,filesize(geo_bd)-1);
  truncate(geo_bd);
  closefile(geo_bd);
  output_rec;
  writeln;
  writeln('������� Enter ��� �������� � ������� ����.');
  readln;
 
end;
 
procedure sort_rec;
const
  n=100;
var
  geo_arr : array [1..n] of geo;
  num,j,i : integer;
  t : geo;
begin
  clrscr;
  writeln('������������ ��������, ��������������� �� �������� �����:');
  writeln('������������ ���������� ���������������� ��. �������   �����');
  i:=0;
  reset(geo_bd);
  while not eof(geo_bd) do
    begin
      read(geo_bd,geo_arr[i+1]);
      inc(i);
    end;
  num:=i;
  for i:=1 to num do
    for j:=i+1 to num do
      if geo_arr[i].ship>geo_arr[j].ship then
        begin
          t := geo_arr[i];
          geo_arr[i]:=geo_arr[j];
          geo_arr[j]:=t;
        end;
  for i:=1 to num do
    begin
      with geo_arr[i] do
        begin
          write(name:5,' ');
          write(amount:15,' ');
          write(capacity:10,' ');
          write(man:18,' ');
          write(ship:10,' ');
        end;
      writeln;
    end;
  writeln('������� Enter ��� �������� � ������� ����.');
  readln;
  closefile(geo_bd);
end;
 
procedure list_rec;
const
  n=100;
var
  geo_arr : array [1..n] of geo;
  num,j,i : integer;
  t : geo;
begin
  clrscr;
  writeln('������������ ��������, ����������������:');
  writeln('���������������� ��.   �����');
  reset(geo_bd);
i:=0;
  reset(geo_bd);
  while not eof(geo_bd) do
    begin
      read(geo_bd,geo_arr[i+1]);
      inc(i);
    end;
  num:=i;
  for i:=1 to num do
    for j:=i+1 to num do
      if geo_arr[i].capacity>geo_arr[j].capacity then
        begin
          t := geo_arr[i];
          geo_arr[i]:=geo_arr[j];
          geo_arr[j]:=t;
        end;
  for i:=1 to num do
    begin
      with geo_arr[i] do
        begin
          write(capacity:10,' ');
          write(ship:17,' ');
        end;
      writeln;
    end;
  writeln('������� Enter ��� �������� � ������� ����.');
  readln;
  closefile(geo_bd);
end;
 
procedure create_bd;
begin
  clrscr;
  writeln('�������� ����� ���� ������:');
  rewrite(geo_bd);
  with my_geo do
    begin
      write('�������� :');             readln(name);
      write('���������� :');                readln(amount);
      write('����������������,�� :');  readln(capacity);
      write('�������:');               readln(man);
      write('����� :');          readln(ship);
    end;
  write(geo_bd,my_geo);
  closefile(geo_bd);
  writeln('������� Enter ��� �������� � ������� ����.');
  readln;
end;
 
begin
  clrscr;
  assignfile(geo_bd,'geo.dat');
  { main loop }
  while true do
    begin
      clrscr;
      writeln('�������� ��������������� ����� ����:');
      writeln('1. ����� ������.');
      writeln('2. ���������� ������.');
      writeln('3. �������� ������.');
      writeln('4. ���������� �������� ����� �� ��������.');
      writeln('5. ������������ ��������, ����������������');
      writeln('6. �������� ����� ���� ������.');
      writeln('0. �����.');
      readln(choice);
      case choice of
        1 : output_rec;
        2 : append_rec;
        3 : delete_rec;
        4 : sort_rec;
        5 : list_rec;
        6 : create_bd;
        0 : exit;
      end; { of case }
    end;
end.