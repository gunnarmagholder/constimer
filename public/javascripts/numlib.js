
// ---------------------------- Zahlen-Bibliothek ---------------------------

/* 'Number-Library 060104' (c) by cybaer@binon.net
   -----------------------
 Inhalt    : Routinen zur formatierten Zahlenausgabe
 Aufruf    : - (Bibliothek)
 Parameter : -
 Sprache   : JavaScript 1.0
 Quelle    : http://Coding.binon.net/NumLib (cybaer@binon.net)
             Die kostenlose Nutzung der Quelltexte in eigenen Projekten ist
             bei nicht-kommerziellen Projekten (und deren unentgeltlicher
             Herstellung) bei Nennung der Quelle ausdruecklich gestattet.
 InlineFunc: -
 Konstante : -
 Variable  : -
 SystemVar : -
 ExternVar : -
 Rueckgabe : -
 Anmerkung : Bei negativen Zahlen erscheint das Minus-Zeichen *vor* den ggf.
             fuehrenden Nullen. Sind jedoch andere Zeichen als fuehrende Nullen
             gewuenscht (z.B. Leerzeichen), so erscheint das Minus-Zeichen *hinter*
             den fuehrenden Zeichen (also direkt vor der eigentlichen Zahl)!
 Beispiele : getFrac(12.34567) ergibt 0.34567
             stringInt(10) ergibt "10" (dezimal)
             stringInt(255,16) ergibt "FF" (hexadezimal)
             stringInt(-10,16,2) ergibt "-0A" (hexadezimal)
             stringInt(010,10)) ergibt "8" (dezimal)
             stringInt(8,8) ergibt "10" (oktal)
             stringInt(5,2,8) ergibt "00000101" (binaer)
             rnd(3) erzeugt eine natuerliche Zahl zw. 1 und 3 (inkl.), also 1, 2 oder 3
             rand(-1,2) erzeugt eine ganze Zahl zw. -1 und 2 (inkl.), also -1, 0, 1 oder 2
             dezRound(5.345847) ergibt 5
             dezRound(53.45847,2) ergibt 53.46
             dezRound(53458.47,-2) ergibt 53500
             dezInt(3,2) ergibt 03
             dezInt(3.1,2) ergibt 03
             dezInt(300,2) ergibt 300
             dezInt(3,4,"+") ergibt +++3
             dezFrac(3,2) ergibt 00
             dezFrac(3.1,2) ergibt 10
             dezFrac(3.001,2) ergibt 001
             dezFrac(3.1,4,"+") ergibt 1+++
             dez(3,2,4) ergibt 03.0000
             dez(-3.1,2,4) ergibt -03.1000
             dez(300.001,2,2) ergibt 300.001
             dez(-3.1,4,4,"#","+",",") ergibt ###-3,1+++
             dez(3.1,0,2,"","0",",") ergibt 3,10
             dez("0010.0100") ergibt 10.01
*/

// 'Ermittle Nachkommaanteil 131203'
function getFrac(num) { num=""+num; return parseFloat("0."+num.substring(num.length-((num.indexOf(".")>=0)?num.length-num.indexOf(".")-1:0),num.length)); }
// 'Zahlenumwandlung 131203' (benoetigt getFrac())
function stringInt(num,base,size) { var i, q, sign, result="", baseTable="0123456789ABCDEF"; num=parseInt(num); sign=(num<0)?"-":""; base=parseInt(base); size=(size)?size:0; if(!base || base<=1 || base>baseTable.length) { base=10; } while(true) { q=num/base; result=baseTable.charAt(parseInt(getFrac(q)*base))+result; num=parseInt(q); if(num==0) { break; } } q=""; size-=result.length; for(i=0;i<size;i++) { q+="0"; } return sign+q+result; }
// 'Runde Zahl 131203'
function dezRound(num,pos) { if(pos<0) { pos=Math.pow(10,Math.abs(pos)); return Math.round(num/pos)*pos; } else if(pos>0) { pos=Math.pow(10,pos); return Math.round(num*pos)/pos; } else { return Math.round(num); } }
// 'Formatierte Zahlenausgabe 021203'
 // Formatierung des Integerbereichs
 function dezInt(num,size,prefix) { prefix=(prefix)?prefix:"0"; var minus=(num<0)?"-":"", result=(prefix=="0")?minus:""; num=Math.abs(parseInt(num,10)); size-=(""+num).length; for(var i=1;i<=size;i++) { result+=""+prefix; } result+=((prefix!="0")?minus:"")+num; return result; }
 // Formatierung des Fliesskommabereichs (benoetigt getFrac())
 function dezFrac(num,size,postfix) { postfix=(postfix)?postfix:"0"; var i, result=getFrac(Math.abs(num)); result=(result)?""+result:""; if(result) { result=result.substring(2,result.length); } size-=result.length; for(i=1;i<=size;i++) { result+=postfix; } return result; }
 // Formatierung realer Zahlen (benoetigt dezInt() & dezFrac())
 function dez(num,presize,postsize,prefix,postfix,fracSign) { fracSign=(fracSign)?fracSign:"."; var result=dezInt(num,presize,prefix)+fracSign+dezFrac(num,postsize,postfix); result=(result.substring(result.length-1,result.length)==fracSign)?result.substring(0,result.length-1):result; return result; }
// 'Natuerliche Zufallszahl 130703' (1<=Zahl<=max)
function rnd(max) { if(Math.random) { return Math.ceil(Math.max(1,max)*Math.random()); } else { return max; } }
// 'Ganze Zufallszahl 060104' (min<=Zahl<=max)
function rand(min,max) { var range=max-min+1; if(range>0) { if(Math.random) { return Math.ceil(range*Math.random())+min-1; } else { return max; } } else { return "undefined"; } }

// --------------------------------------------------------------------------

