// zadanie spiski 3
type PNode = ^Node;
     Node = record
       word: string[40];
       data: integer;
       next: PNode;
     end;

var Head: ^Node;
var i: integer;

function CreateNode(data: integer): ^Node;
var
  newNode: ^Node;
begin
  new(newNode);
  newNode^.data := data;
  newNode^.next := nil;
  result := newNode;
end;


procedure AddFirst ( var Head: PNode; NewNode: PNode );
begin
  NewNode^.next := Head;
  Head := NewNode;
end;


procedure AddAfter ( var pp: PNode; NewNode: PNode );
begin
  NewNode^.next := pp^.next;
  pp^.next := NewNode;
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
    AddAfter ( pp, NewNode ); // после узла pp добавляем узел
  end;
end;

procedure vivesti_listochek(Head: ^Node);
var c: ^Node;
begin
  c := Head;
  while c <> nil do
  begin
    write(c^.data,' ');
    c := c^.next;
  end;
end;

procedure min_max(Head: ^Node);
var c: ^Node;  min, max : integer;
begin
  c := Head;
  min := c^.data;
  max := c^.data;
  while c <> nil do
  begin
    if c^.data > max then
      max := c^.data;
    if c^.data < min then
      min := c^.data;
    c := c^.next;
  end;
  writeln(min,' ', max);
end;
  

begin
  Head := nil;

  for i := 1 to 10 do
  begin
    AddLast(Head, CreateNode(random(101)));
  end;

  writeln('списочек:');
  vivesti_listochek(Head);
  writeln();
  writeln('минимальный и максимальный элементы:');
  min_max(Head);
end.