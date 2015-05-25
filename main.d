import std.stdio;

import inputh;
import input:Input;
import input:read;

import functionh;
import funct;

enum RUNS= 58;

void main(){
  write( "Milkysim 1.1 says: ");
  debug writeln("scan");
  auto defender= read( "scan.txt");
  debug writeln("praes");
  auto base= read( "praesent.txt");
  debug writeln("nach");
  auto reinforcement= read( "nachschb.txt");

  version( chatty){
    writeln( "Du hast folgende Einheiten:");
    writeln( base);
    writeln( "Du hast folgendes als Nachschubkontingent bestimmt:");
    writeln( reinforcement);
    writeln( "Dein Gegner hat folgende Einheiten:");
    writeln( defender);
    import std.math:floor;
    uint x( real y){ return cast(int)( floor( (y-1)*10 + 0.5));}
    writefln( "Waffentechnik: Du= %d, Gegner= %d", x(base.wsh.weapon), x(defender.wsh.weapon));
    writefln( "Schildtechnik: Du= %d, Gegner= %d", x(base.wsh.shield), x(defender.wsh.shield));
    writefln( "Raumschiffpanzerung: Du= %d, Gegner= %d", x(base.wsh.hull), x(defender.wsh.hull));
    writefln( "%d von %d Simulationen muessen Sieg ergeben.",
           base.runs - base.threshold, base.runs);
  }

  auto destructed= new Destructed;
  auto rapids= new Rapids;
  auto result= simulate( base.runs, false,
               	  base.wsh, base.unitCount,
	          defender.wsh, defender.unitCount,
		  destructed, rapids);
  if( result[ -1] == base.runs)
    writeln( true);
  else
    writefln( "false %d %d", result[ 0], result[ 1]);

}
unittest{
  auto destructed= new Destructed;
  auto rapids= new Rapids;
  writeln( fight( base.wsh, base.unitCount,
	          defender.wsh, defender.unitCount,
		  destructed, rapids));
}
/* vim:set nu sw=2 nowrap: */
