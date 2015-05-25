import std.stdio:write;
import std.stdio:writeln;
import std.stdio:writefln;
import std.stream:File;
import std.regex:regex;
import std.regex:split;
import std.utf:toUTF8;
import std.conv:to;
import std.ascii:isAlphaNum;
import std.ascii:isDigit;

enum RUNS= 58;

import inputh;
struct Input{
  UnitCount unitCount;
  WSH wsh;
  uint runs;
  uint threshold;
  real risk; // TODO export it
  uint finalRuns; // TODO export it

  debug string toString(){
    return "NOT YET IMPLEMENTED";
  }
}
Input read( string fileName){
  debug writeln("[read ");
  Input data;
  with( data){
    auto scan = new File( fileName);
    unitCount= new UnitCount;
    string line;
    string[] fields;
    auto tab= regex( "\t");
    auto space= regex( "(\t|[ ])+");https://www.youtube.com/watch?v=ApK-U-6DQdU
    outputs.length= 0;
    bool isNumber(string s){
      int i;
      if( !s.length) return false;
      for( i= 0; i < s.length && isDigit(s[i]); i++){}
      return i == s.length;
    }
    runs= RUNS;

    while (!scan.eof){
      char[] sline= scan.readLine();
      uint idx=0;
      line.length=0;
      while( idx < sline.length){
	char c= sline[ idx++ ];
	char[4] buf;
	switch ( c){
	  case 228: line~=toUTF8(buf, 'ä'); break;
	  case 196: line~=toUTF8(buf, 'Ä'); break;
	  case 246: line~=toUTF8(buf, 'ö'); break;
	  case 214: line~=toUTF8(buf, 'Ö'); break;
	  case 252: line~=toUTF8(buf, 'ü'); break;
	  case 220: line~=toUTF8(buf, 'Ü'); break;
	  case 223: line~=toUTF8(buf, 'ß'); break;
	  break;
	  default: line~= c;
	}
      }
      // validate( line);
      //fields= split( line, space);
      fields= line.split( space);
      string name="";
      uint number;
      for( int i= 0; i < fields.length; i++){
	if( fields[ i].length)
	if( ! isNumber( fields[i])){
	  debug writefln("field is\"%s\"", fields[i]);
	  if( isAlphaNum( fields[ i][0]))
	  if( name.length > 0)
	    name~= " " ~ fields[ i].dup;
	  else
	    name= fields[ i].dup;
	  debug writefln( "name now \"%s\"", name);
	} else {
	    number= to!int(fields[i]);
	    debug writefln("number is %d", number);
	    switch( name){
	      case "Kleiner Transporter": unitCount[ UT.KT]= number;
		break;
	      case "Großer Transporter": unitCount[ UT.GT]= number;
		break;
	      case "Leichter Jäger": unitCount[ UT.LJ]= number;
		break;
	      case "Schwerer Jäger": unitCount[ UT.SJ]= number;
		break;
	      case "Kreuzer": unitCount[ UT.KREUZER]= number;
		break;
	      case "Schlachtschiff": unitCount[ UT.SS]= number;
		break;
	      case "Kolonialisierungsschiff": unitCount[ UT.KOLO]= number;
		break;
	      case "Solar Satellit": unitCount[ UT.SOLAR]= number;
		break;
	      case "Spionagesonde": unitCount[ UT.SPIO]= number;
		break;
	      case "Recycler": unitCount[ UT.RECY]= number;
		break;
	      case "Bomber": unitCount[ UT.BOMBER]= number;
		break;
	      case "Zerstörer": unitCount[ UT.ZERSTOERER]= number;
		break;
	      case "Todesstern": 
		debug writeln("RIP");
		unitCount[ UT.RIP]= number;
		debug writeln("RIP");
		break;
	      case "Schlachtkreuzer": unitCount[ UT.SK]= number;
		break;
	      case "Raketenwerfer": unitCount[ UT.RAK]= number;
		break;
	      case "Leichtes Lasergeschütz": unitCount[ UT.LL]= number;
		break;
	      case "Schweres Lasergeschütz": unitCount[ UT.SL]= number;
		break;
	      case "Gaußkanone": unitCount[ UT.GAUSS]= number;
		break;
	      case "Ionengeschütz": unitCount[ UT.ION]= number;
		break;
	      case "Plasmawerfer": unitCount[ UT.PLASMA]= number;
		break;
	      case "Kleine Schildkuppel": unitCount[ UT.KS]= number;
		break;
	      case "Große Schildkuppel": unitCount[ UT.GS]= number;
		break;
	      case "Waffentechnik": wsh.weapon= 1 + 0.1 * number;
		break;
	      case "Schildtechnik": wsh.shield= 1 + 0.1 * number;
		break;
	      case "Raumschiffpanzerung": wsh.hull= 1 + 0.1 * number;
		break;
	      case "Restrisiko": 
		if( number <= 0) throw new Error("Illegales Restrisiko angegeben");
		risk= number/ 1000.0L;
		break;
	      case "Rechenzeit":
		if( number <= 0) throw new Error("Illegale Rechenzeit angegeben");
		finalRuns= number;
		break;
	      case "Runs":
		if( number <= 0) throw new Error("Illegale Runs angegeben");
		runs= number;
		break;
	      default:
		debug writeln("default");
		outputs.length= outputs.length + 1;
		outputs[ outputs.length -1]= "\"" ~ name ~ "\"";
	    }
	    name= "";
	}
      }
    }
    scan.close(); 
    if( runs < 1)runs=1;
    // TODO if( threshold > anz( runs, risk))threshold= anz( runs, risk);
    //transformCU( unitCount, units);
    if( outputs.length){
      string output= "";
      for( int i= 0; i< outputs.length; i++){
	output~= outputs[i] ~ "\n";
      }
      version(win)
      MessageBoxA( null, output, "MilkySim: ignorierte Daten ("~ fileName ~")",
	MB_OK | MB_ICONINFORMATION);
      else {
	write("%s", "milkysim: ignorierte Daten ("~ fileName ~")\n");
	writeln("%s", output);
      };
    }
  }
  debug writeln("read]");
  return data;
}
unittest{
  auto result= read( "scan.txt");
  writeln( result);
}
/* vim:set nu sw=2 nowrap: */
