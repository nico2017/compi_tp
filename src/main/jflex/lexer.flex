package lyc.compiler;

import java_cup.runtime.Symbol;
import lyc.compiler.ParserSym;
import lyc.compiler.model.*;
import static lyc.compiler.constants.Constants.*;

%%

%public
%class Lexer
%unicode
%cup
%line
%column
//%throws CompilerException
%eofval{
  return symbol(ParserSym.EOF);
%eofval}


%{
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
Init = "Init"

FloatConstant = "-"?{Digit}*{Pto}{Digit}+|{Digit}+{Pto}{Digit}*
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
IntegerConstant = "-"?{Digit}+
WhiteSpace = {LineTerminator} | {Identation}
Identifier = {Letter} ({Letter}|{Digit})*


%%


/* keywords */

<YYINITIAL> {
  /* operators */

  {Plus}                                    { return symbol(ParserSym.PLUS); }
  {Sub}                                     { return symbol(ParserSym.SUB); }
  {Mult}                                    { return symbol(ParserSym.MULT); }
  {Div}                                    { return symbol(ParserSym.DIV); }
  {Assig}                                   { return symbol(ParserSym.ASSIG); }
  {OpenBracket}                             { return symbol(ParserSym.OPEN_BRACKET); }
  {CloseBracket}                            { return symbol(ParserSym.CLOSE_BRACKET); }
  {Div}                                    { return symbol(ParserSym.DIV); }
  {FloatConstant}                                    { return symbol(ParserSym.FLOATCONSTANT, yytext()); }
  {KeyOpen}                                    { return symbol(ParserSym.KEYOPEN); }
  {KeyClose}                                    { return symbol(ParserSym.KEYCLOSE); }
  {CorchOpen}                                    { return symbol(ParserSym.CORCHOPEN); }
  {CorchClose}                                    { return symbol(ParserSym.CORCHCLOSE); }
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
  {Init}                                    { return symbol(ParserSym.INIT, yytext()); }
  {CMP_DIST}                                    { return symbol(ParserSym.CMP_DIST, yytext()); }
  {CMP_IGUAL}                                    { return symbol(ParserSym.CMP_IGUAL, yytext()); }
  {CMP_MA}                                    { return symbol(ParserSym.CMP_MA, yytext()); }
  {CMP_MA_IGUAL}                                    { return symbol(ParserSym.CMP_MA_IGUAL, yytext()); }
  {CMP_ME}                                    { return symbol(ParserSym.CMP_ME, yytext()); }
  {CMP_ME_IGUAL}                                    { return symbol(ParserSym.CMP_ME_IGUAL, yytext()); }

  {StrConstant}                                    { return symbol(ParserSym.STRCONSTANT, yytext()); }
  /* identifiers */
  {Identifier}                             { return symbol(ParserSym.IDENTIFIER, yytext()); }
  /* Constants */
  {IntegerConstant}                        { return symbol(ParserSym.INTEGER_CONSTANT, yytext()); }
  {Comentarios}                  { return symbol(ParserSym.COMENTARIOS, yytext());}
  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }

}


/* error fallback */
[^]                              {  }