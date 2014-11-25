type operator = Add | Sub | Mul | Div
type eq = Equal | Neq | Lt | Leq | Gt | Geq 
type re = And | Or
type types = Int | Boolean | String | Element | Molecule | Equation | Double

type expr =
    Binop of expr * operator * expr
  | Bexpr of expr * eq * expr
  | Brela of expr * re * expr
  | Int of int
  | String of string 
  | Balance of string
  | Asn of string * expr
  | Element of string * int * int * int
  | Molecule of string * string list
  | Equation of string * string list * string list
  | Concat of string * string
  | Seq of expr * expr 
  | List of expr list 
  | Equal of expr
  | Var of string
  | Call of string * expr list
  | Null 
  | Noexpr


type stmt = 
    Block of stmt list
  | Expr of expr
  | Return of expr
  | If of expr * stmt * stmt
  | For of expr * expr * expr * stmt
  | While of expr * stmt
  | Loop of string * string * stmt
  | Print of expr


(* type var_decl = {
  vtype: types list;
  vname: string;
} *)




(* type program = {
  objectdecls : object_decl list;
  gdecls : var_decl list;
  fdecls : func_decl list
} *)





type program = stmt list