%{ open Ast %}

%token SEMI LPAREN RPAREN LBRACKET RBRACKET LCURLY RCURLY COMMA
%token PLUS MINUS TIMES DIVIDE MOD ASSIGN 
%token EQ NEQ LT LEQ GT GEQ
%token RETURN IF ELSE WHILE INT DOUBLE STRING BOOLEAN ELEMENT MOLECULE EQUATION FUNCTION
%token DOT
%token AND OR
%token <bool> BOOLEAN_LIT
%token <string> STRING_LIT
%token <string> ID
%token <int> INT_LIT
%token <float> DOUBLE_LIT
%token EOF

%nonassoc NOELSE
%nonassoc ELSE
%left SEMI
%right FUNC
%right ASSIGN
%left PLUS MINUS
%left TIMES DIVIDE

%start program
%type <Ast.program> program

%%
program:
					{ [] }
	| program fdecl { ($2 :: $1)}

fdecl: 
	FUNCTION datatype id LPAREN formals_list RPAREN LCURLY stmt RCURLY
		{ Func({
			fname = $3;
			formals = $5;
			body = List.rev $8;
			ret = $2;
		}) }

formals_list:
	  datatype id						{ Var_Decl($1, $2) }
	| formals_list COMMA datatype id	{ List.rev $3 :: $1 }

id: 
	ID {$1}

expr:
	  expr PLUS expr { Binop($1, Add, $3) }
	| expr MINUS expr { Binop($1, Sub, $3) }
	| expr TIMES expr { Binop($1, Mul, $3) }
	| expr DIVIDE expr { Binop($1, Div, $3) }
	| INT_LIT { Lit($1) }
	| STRING_LIT {String_Lit($1)}
	| DOUBLE_LIT {Double_Lit($1)}
	| ID { Var($1) }
	| ID ASSIGN expr { Asn($1, $3) }

datatype:
	  BOOLEAN {Boolean}
	| INT	{Int}
	| DOUBLE {Double}
	| STRING {String}
	| ELEMENT {Element}
	| MOLECULE {Molecule}
	| EQUATION {Equation}

element:
	STRING_LIT {element($1)}

element_list:
	  element 		{[]}
	| element_list COMMA element 	{ ($3 :: $1) }

molecule:
	| LBRACKET element_list RBRACKET {mol($2)}

molecule_list:
	molecule 	{[]}
	|  molecule_list COMMA molecule  {mol_list($1, $3)}

equation:
	LCURLY molecule_list SEMI molecule_list RCURLY {eqtn($2, $4)}

stmt:
	  expr SEMI										{ Expr($1) }
	| FUNCTION LPAREN formals_list RPAREN SEMI		{ func_call($3) }
	| RETURN expr SEMI								{ Return($2) }
	| IF LPAREN expr RPAREN LCURLY stmt RCURLY ELSE LCURLY stmt RCURLY {If($3, $6, $10)}
	| WHILE LPAREN expr RPAREN LCURLY stmt RCURLY {While($3, $6)}




