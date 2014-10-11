# TARFILES = Makefile scanner.mll parser.mly ast.mli chemlab.ml

OBJS = parser.cmo scanner.cmo chemlab.cmo

chemlab : $(OBJS)
	ocamlc -o chemlab $(OBJS)

scanner.ml : scanner.mll
	ocamllex scanner.mll

parser.ml parser.mli : parser.mly
	ocamlyacc parser.mly

%.cmo : %.ml
	ocamlc -c $<

%.cmi : %.mli
	ocamlc -c $<

# calculator.tar.gz : $(TARFILES)
# 	cd .. && tar zcf calculator/calculator.tar.gz $(TARFILES:%=calculator/%)

.PHONY : clean
clean :
	rm -f chemlab parser.ml parser.mli scanner.ml *.cmo *.cmi

# Generated by ocamldep *.ml *.mli
chemlab.cmo: scanner.cmo parser.cmi ast.cmi 
chemlab.cmx: scanner.cmx parser.cmx ast.cmi 
parser.cmo: ast.cmi parser.cmi 
parser.cmx: ast.cmi parser.cmi 
scanner.cmo: parser.cmi 
scanner.cmx: parser.cmx 
parser.cmi: ast.cmi 
