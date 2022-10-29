package lyc.compiler;

import java_cup.runtime.Symbol;
import lyc.compiler.ParserSym;
import lyc.compiler.files.SymbolTableGenerator;import lyc.compiler.model.*;
import static lyc.compiler.constants.Constants.*;
import lyc.compiler.files.FileOutputWriter;
%%

%public
%class Lexer
%unicode
%cup
%line
%column
//%throws CompilerException
%eofval{
    String tableCSV = "";
    tableCSV+=cteInt;
    tableCSV+=cteStr;
    tableCSV+=cteFloat;
    tableCSV+=identif;

    SymbolTableGenerator s = new SymbolTableGenerator();
    s.setTableSymbol(tableCSV);
    FileOutputWriter.writeOutput("symbol-table1.txt",s);

    //System.out.println(tableCSV);
    return symbol(ParserSym.EOF);
%eofval}


%{
  String cteInt = "";
  String cteStr = "";
  String cteFloat = "";
  String identif = "";
  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}


LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
Identation =  [ \t\f]

Comentarios = "/*".*."*/"

//PALABRAS RESERVADAS
If = "if"|"IF"
While = "while"|"WHILE"
Else = "ELSE"|"else"
Write =  "write"
Read = "read"
And = "AND"
Not = "NOT"
Or = "OR"
DecStr = "String"
DecInt = "Int"
DecFloat = "Float"
Void = void
Init = "Init"|"init"
Repeat = "REPEAT"
Do = "DO"
Case = "CASE"
Enddo = "ENDDO"
Default="DEFAULT"

FloatConstant = {Digit}*{Pto}{Digit}+|{Digit}+{Pto}{Digit}*
Plus = "+"
Mult = "*"
Sub = "-"
Div = "/"
Assig = "="|":="
OpenBracket = "("
CloseBracket = ")"
Letter = [a-zA-Z]
Digit = [0-9]
KeyOpen = "{"
KeyClose = "}"
CorchOpen = "["
CorchClose = "]"
DosPuntos = ":"
PtoComa=";"
Coma =","
CMP_DIST = "!="|"<>"
CMP_IGUAL=	"=="
CMP_MA	=	">"
CMP_MA_IGUAL =	">="
CMP_ME		= "<"
CMP_ME_IGUAL =	"<="
Pto = "."
StrConstant = "\"".*."\""
IntegerConstant = {Digit}+
WhiteSpace = {LineTerminator} | {Identation}
Identifier = {Letter} ({Letter}|{Digit})*


%%


/* keywords */

<YYINITIAL> {
  /* operators */

  {Plus}                                      { return symbol(ParserSym.PLUS); }
  {Sub}                                       { return symbol(ParserSym.SUB); }
  {Mult}                                      { return symbol(ParserSym.MULT); }
  {Div}                                          { return symbol(ParserSym.DIV); }
  {Assig}                                   { return symbol(ParserSym.ASSIG); }
  {OpenBracket}                             { return symbol(ParserSym.OPEN_BRACKET); }
  {CloseBracket}                            { return symbol(ParserSym.CLOSE_BRACKET); }
  {KeyOpen}                                    { return symbol(ParserSym.KEYOPEN); }
  {KeyClose}                                    { return symbol(ParserSym.KEYCLOSE); }
  {CorchOpen}                                    { return symbol(ParserSym.CORCHOPEN); }
  {CorchClose}                                    { return symbol(ParserSym.CORCHCLOSE); }
    {Repeat}                                    { return symbol(ParserSym.REPEAT, yytext()); }
    {Do}                                    { return symbol(ParserSym.DO, yytext()); }
    {Case}                                    { return symbol(ParserSym.CASE, yytext()); }
    {Enddo}                                    { return symbol(ParserSym.ENDDO, yytext()); }
    {Default}                                    { return symbol(ParserSym.DEFAULT, yytext()); }

  {If}                                    { return symbol(ParserSym.IF, yytext()); }
  {While}                                    { return symbol(ParserSym.WHILE, yytext()); }
  {Else}                                    { return symbol(ParserSym.ELSE, yytext()); }
  {Pto}                                    { return symbol(ParserSym.PTO); }
  {Write}                                    {return symbol(ParserSym.WRITES, yytext()); }
  {Read}                                    { return symbol(ParserSym.READ, yytext()); }
  {And}                                    { return symbol(ParserSym.AND, yytext()); }
  {Not}                                    { return symbol(ParserSym.NOT, yytext()); }
  {Or}                                    { return symbol(ParserSym.OR, yytext()); }
  {DecStr}                                    { return symbol(ParserSym.DECSTR, yytext()); }
  {DecInt}                                    { return symbol(ParserSym.DECINT, yytext()); }
  {DecFloat}                                    { return symbol(ParserSym.DECFLOAT, yytext()); }
  {Void}                                    { return symbol(ParserSym.VOID, yytext()); }
  {DosPuntos}                                    { return symbol(ParserSym.DOSPUNTOS); }
  {PtoComa}                                    { return symbol(ParserSym.PTOCOMA); }
  {Coma}                                    { return symbol(ParserSym.COMA); }
  {Init}                                    { return symbol(ParserSym.INIT, yytext()); }
  {CMP_DIST}                                    { return symbol(ParserSym.CMP_DIST, yytext()); }
  {CMP_IGUAL}                                    { return symbol(ParserSym.CMP_IGUAL, yytext()); }
  {CMP_MA}                                    { return symbol(ParserSym.CMP_MA, yytext()); }
  {CMP_MA_IGUAL}                                    { return symbol(ParserSym.CMP_MA_IGUAL, yytext()); }
  {CMP_ME}                                    { return symbol(ParserSym.CMP_ME, yytext()); }
  {CMP_ME_IGUAL}                                    { return symbol(ParserSym.CMP_ME_IGUAL, yytext()); }

  {FloatConstant}               /* Valido rango de Real */          { float tope = 214748364 ; float numberf = Float.parseFloat(yytext()); if ( numberf > tope  || numberf < -tope ) {System.out.println("Numero fuera de rango: "); System.out.println(yytext()); break; }  return symbol(ParserSym.FLOATCONSTANT, yytext()); }

  {StrConstant}                 /* Valido el largo de la Cadena */  { int stringLength = yytext().length(); if (stringLength > 30){System.out.println("Cadena muy larga: "); System.out.println(yytext()); break; };  return symbol(ParserSym.STRCONSTANT, yytext()); }
  /* identifiers */
  {Identifier}                                                                  {  return symbol(ParserSym.IDENTIFIER, yytext()); }
  /* Constants */
  {IntegerConstant}            /* Valido rango del Entero */        { int number = Integer.parseInt(yytext());  if ( number > 32769 || number < -32767) {System.out.println("Numero fuera de rango: "); System.out.println(yytext()); break; } ; return symbol(ParserSym.INTEGER_CONSTANT, yytext()); }
  {Comentarios}                             { return symbol(ParserSym.COMENTARIOS, yytext());}
  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }

}


/* error fallback */
[^]                              {  }