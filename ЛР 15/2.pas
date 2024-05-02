type PNode = ^Node;   { указатель на узел }   
     Node = record    { структура узла }
       wrd: string[40]; { слово }
       cnt: integer;   { счетчик повторов слов }
       next: PNode;      { ссылка на следующий }
     end;
     
var Head, NewNode, pp: PNode; filee: text; cnt: integer; wordd: string;



function CreateNode(NewWord: string): PNode;
var
  NewNode: PNode;
begin
  New(NewNode);
  NewNode^.wrd   := NewWord;
  NewNode^.cnt := 1;
  NewNode^.Next    := nil;
  Result := NewNode;
end;

procedure AddNext(p, NewNode: PNode);
begin
  NewNode^.Next := p^.Next;
  p^.Next := NewNode;
end;


procedure AddFirst(var Head: PNode; NewNode: PNode);
begin
  NewNode^.Next := Head;
  Head := NewNode;
end;



procedure AddLast ( var Head: PNode; NewNode: PNode );
var pp: PNode;
begin
  if Head = nil then
    AddFirst ( Head, NewNode ) // добавляем в пустой список
  else begin
    pp := Head;
    while pp^.next <> nil do // поиск последнего узла
      pp := pp^.next;
    AddNext ( pp, NewNode ); // после узла pp добавляем узел
  end;
end;



procedure AddBefore(var Head: PNode; p, NewNode: PNode);
var pp: PNode;
begin
  pp := Head;
  if p = Head then
    AddFirst ( Head, NewNode )  // добавление в начало списка
  else begin
    while (pp <> nil)  and  (pp^.next <> p) do // поиск узла, за которым следует узел p
      pp := pp^.next;
    if pp <> nil then AddNext ( pp, NewNode ); // добавляем после узла pp
  end;
end;



function Find(Head: PNode; NewWord: string): PNode;
var
  pp: PNode;
begin
  pp := Head;
  while (pp <> nil) and (pp^.wrd <> NewWord) do
    pp := pp^.Next;
  Result := pp;
end;



function FindPlace(Head: PNode; NewWord: string): PNode;
var
  pp: PNode;
begin
  pp := Head;
  while (pp <> nil) and (NewWord > pp^.wrd) do
    pp := pp^.Next;
  Result := pp;
end;



function TakeWord ( F: Text ) : string;
var c: char;
begin
  Result := ''; { пустая строка }
  c := ' ';     { пробел – чтобы войти в цикл }  
    { пропускаем спецсимволы и пробелы }
  while not eof(f) and (c <= ' ') do 
    read(F, c);  
    { читаем слово }  
  while not eof(f) and (c > ' ') do begin
    Result := Result + c;
    read(F, c);
  end;
end;



begin
  Head := nil;
  Assign(filee, 'slovarik.txt');
  Reset(filee);
  
  while not eof(filee) do begin
    wordd := TakeWord(filee);
    if (wordd = '') then break;
    pp := Find(Head, wordd);
    if (pp <> nil) then pp^.cnt += 1
    else begin
      NewNode := CreateNode(wordd);
      pp := FindPlace(Head, wordd);
      AddBefore(Head, pp, NewNode);
    end;
  end;
  Close(filee);
  pp := Head;
  cnt := 0;
  while (pp <> nil) do
  begin
    Inc(cnt);;
    pp := pp^.Next;
  end;
  Writeln('Количество уникальных слов – ', cnt);
end.