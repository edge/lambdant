%parse-param af
%start program

%%

program
	: expr EOF { return $1 }
	;

expr
	: expr value -> af.expr($1, $2)
	| expr INFIX value -> af.expr($3, $1)
	| value
	;

value
	: NUM -> af.value(Number($1))
	| ID -> af.id($1)
	| LPAREN expr RPAREN -> $2
	| lambda
	;

lambda
	: LSQUARE idlist ARROW expr RSQUARE -> af.fn($2, $4)
	;

idlist
	: idlist ID -> $1.concat($2)
	| ID -> [$1]
	;
