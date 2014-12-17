OBJS = ast.cmo parser.cmo scanner.cmo helper.cmo semantic.cmo compile.cmo chemlab.cmo

chemlab : $(OBJS)
	ocamlc str.cma -o chemlab $(OBJS)

scanner.ml : scanner.mll
	ocamllex scanner.mll

parser.ml parser.mli : parser.mly
	ocamlyacc parser.mly

%.cmo : %.ml
	ocamlc -c $<

%.cmi : %.mli
	ocamlc -c $<

.PHONY : clean
clean :
	rm -f chemlab parser.ml parser.mli scanner.ml *.cmo *.cmi *.class  test/*.out

# Generated by ocamldep *.ml *.mli
ast.cmo : ast.cmi
ast.cmx : ast.cmi
chemlab.cmo : scanner.cmo parser.cmi compile.cmo ast.cmi
chemlab.cmx : scanner.cmx parser.cmx compile.cmx ast.cmx
compile.cmo : ast.cmi
compile.cmx : ast.cmx
parser.cmo : ast.cmi parser.cmi
parser.cmx : ast.cmx parser.cmi
scanner.cmo : parser.cmi
scanner.cmx : parser.cmx
semantic.cmo : ast.cmi
semantic.cmx : ast.cmx
ast.cmi :
parser.cmi : ast.cmi
