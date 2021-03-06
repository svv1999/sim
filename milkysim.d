enum UnitType {KT, GT,
           LJ, SJ, KREUZER, SS, KOLO, RECY, SPIO,
           BOMBER, SOLAR, ZERSTOERER, RIP, SK,
           RAK, LL, SL, GAUSS, ION, PLASMA,
           KS, GS};
alias UnitType UT;
enum UnitClass { DEF, STAT, CIV, FGHT};
alias UnitClass UC;
struct Properties{
  UnitClass classs;
  string typName;
  double weapon, shield, hull, metal, crystal, deut, capacity;
}
Properties[ UnitType.max + 1] properties=[
{ UC.CIV,  "KT", 5, 10, 400, 2000, 2000, 0, 5000},  //kt
{ UC.CIV,  "GT", 5, 25, 1200, 6000, 6000, 0, 25000}, //gt
{ UC.FGHT, "LJ", 50, 10, 400, 3000, 1000, 0, 50}, //lj
{ UC.FGHT, "SJ", 150, 25, 1000, 6000, 4000, 0, 100}, //sj
{ UC.FGHT, "KREUZER", 400, 50, 2700, 20000, 7000, 2000, 800}, //KREUZER
{ UC.FGHT, "SS", 1000, 200, 6000, 40000, 20000, 0, 1500}, //SS
{ UC.CIV,  "KOLO", 50, 100, 3000, 10000, 20000, 10000, 7500}, //KOLO
{ UC.CIV,  "RECY", 1, 10, 1600, 10000, 6000, 2000, 20000}, //RECY
{ UC.STAT, "SPIO", 0.01, 0.01, 100, 0, 1000, 0, 0}, //SPIO
{ UC.FGHT, "BOMBER", 1000, 500, 7500, 50000, 25000, 15000, 500}, //BOMBER
{ UC.STAT, "SOLAR", 1, 1, 200, 0, 2000, 500, 0}, //SOLAR
{ UC.FGHT, "ZERSTOERER", 2000, 500, 11000, 60000, 50000, 15000, 2000}, // ZERSTOERER
{ UC.FGHT, "RIP", 200000, 50000, 900000, 5000000, 4000000, 1000000, 1000000}, //RIP
{ UC.FGHT, "SK", 700, 400, 7000, 30000, 40000, 15000, 750}, //SK
{ UC.DEF,  "RAK", 80, 20, 200, 2000, 0, 0, 0},  //RAK
{ UC.DEF,  "LL", 100, 25, 200, 1500, 500, 0, 0}, //LL
{ UC.DEF,  "SL", 250, 100, 800, 6000, 2000, 0, 0}, //SL
{ UC.DEF,  "GAUSS", 1100, 200, 3500, 20000, 15000, 2000, 0}, //GAUSS
{ UC.DEF,  "ION", 150, 500, 800, 2000, 6000, 0, 0}, //ION
{ UC.DEF,  "PLASMA", 3000, 300, 10000, 50000, 50000, 30000, 0}, //PLASMA
{ UC.DEF,  "KS", 1, 2000, 2000, 10000, 10000, 0, 0}, //KS
{ UC.DEF,  "GS", 1, 10000, 10000, 50000, 50000, 0, 0}]; //GS

  import std.random:rndGen;
  real random(){
    rndGen.popFront;
    return rndGen.front/real.max;
  }
unittest{
  assert( random() != random());
}

class RapidFire{
  static uint [ UnitType.max + 1][ UnitType.max + 1] rapidFire;
  
  static this(){
    for( UT left= UT.min; left <= UT.max; left++){
      for( UT right= UT.min; right <= UT.max; right++){
	rapidFire[ left][ right]= 1;
      }
    }
    for( UT left= UT.min; left <= UT.max; left++){
	rapidFire[ left][ UT.SPIO]= 5;
    }
    for( UT left= UT.min; left <= UT.max; left++){
	rapidFire[ left][ UT.SOLAR]= 5;
    }
    for( UT left= UT.min; left <= UT.max; left++) with( UnitType){
      rapidFire[ SJ][ KT]= 3; // 3 Objekte
      rapidFire[ KREUZER][ LJ]= 6; // 6 Objekte
      rapidFire[ KREUZER][ RAK]= 10; // 10 Objekte
      rapidFire[ SK][ KT]= 3; // 3 Objekte
      rapidFire[ SK][ GT]= 3; // 3 Objekte
      rapidFire[ SK][ SJ]= 4; // 4 Objekte
      rapidFire[ SK][ KREUZER]= 4; // 4 Objekte
      rapidFire[ SK][ SS]= 7; // 7 Objekte
      rapidFire[ BOMBER][ RAK]= 20; //20 "
      rapidFire[ BOMBER][ LL]= 20; // 20 "
      rapidFire[ BOMBER][ SL]= 10; // 10 "
      rapidFire[ BOMBER][ ION]= 10; // 10 "
      rapidFire[ ZERSTOERER][ LL]= 10; // 10 Objekte
      rapidFire[ ZERSTOERER][ SK]= 2; // 2 Objekte
      rapidFire[ RIP][ KT]= 250; // 250"
      rapidFire[ RIP][ GT]= 250; // 250"
      rapidFire[ RIP][ LJ]= 200; // 200"
      rapidFire[ RIP][ SJ]= 100; // 100"
      rapidFire[ RIP][ KREUZER]= 33; // 33"
      rapidFire[ RIP][ SS]= 30; // 30"
      rapidFire[ RIP][ KOLO]= 250; // 250"
      rapidFire[ RIP][ RECY]= 250; // 250"
      rapidFire[ RIP][ SPIO]= 1250; // 1250"
      rapidFire[ RIP][ SOLAR]= 1250; // 1250"
      rapidFire[ RIP][ BOMBER]= 25; // 25"
      rapidFire[ RIP][ ZERSTOERER]= 5; // 5"
      rapidFire[ RIP][ RAK]= 200; // 200"
      rapidFire[ RIP][ LL]= 200; // 200"
      rapidFire[ RIP][ SL]= 100; // 100"
      rapidFire[ RIP][ GAUSS]= 50; // 50"
      rapidFire[ RIP][ ION]= 100; // 100"
      rapidFire[ RIP][ SK]= 15; // 15"
    }
  }
  static bool opCall( UT left, UT right){
    return random() < (1.0L-1.0L/cast(real)rapidFire[ left][ right]);
  }
}
unittest{
  assert( !RapidFire( UT.KREUZER, UT.LL));
}

struct WSH{
  double weapon=1.0, shield=1.0, hull=1.0;
};

class UnitCount{
  uint position= 0;
  struct UCs{
    uint count;
    uint[ UT.max + 1 ] data;
  }
  UCs[] data;
  this(){
    data.length= 1000;
    data.length= 1;
    for( int i= 0; i <= UT.max; i++){
      data[0].data[i]=0;
    }
    data[ 0].count= 0;
  }
  UnitCount dup(){
    UnitCount retVal= new UnitCount;
    retVal.position= position;
    for( int i= 0; i < data.length; i++){
      retVal.data[i] = data[i];
    }
    return retVal;
  }
  uint opIndex( int i){
    return data[ position].data[ i];
  }
  uint opIndexAssign( uint value, int i){
    data[ position].data[ i]= value;
    data[ position].count+= value;
    return value;
  }
  UnitCount opAdd( UnitCount right){
    UnitCount result= new UnitCount;
    for( int i= 0; i <= UT.max; i++){
      result[ i]= this[i] + right[ i];
    }
    result.count= this.count + right.count;
    return result;
  }
  void opMul( uint multiplicator){
    for( int i= 0; i <= UT.max; i++){
      data[ position].data[ i]*=multiplicator;
    }
    count=count* multiplicator;
  }
  void opDiv( uint divisor){
    for( int i= 0; i <= UT.max; i++){
      data[ position].data[ i]/=divisor;
    }
    count=count/ divisor;
  }
  uint count(){
    return data[ position].count;
  }
  uint count( uint newVal){
    data[ position].count= newVal;
    return newVal;
  }
  void opPostInc(){
    data[ position].count++;
  }
  void opPostDec(){
    data[ position].count--;
  }
  void remove( ref Units units){
    uint offset= 0;
    bool isDestructed( Unit unit){
      return  unit.property.hull<=0 
           || unit.property.hull< 0.7L * properties[ unit.typ].hull
	      && unit.property.hull < random() * properties[ unit.typ].hull;
    }
    for( int i= 0; i< units.length; i++){
      units[ i - offset]= units[ i];
      if( isDestructed( units[ i])){
	offset++;
	this[ units[ i].typ]= this[ units[i].typ] + 1;
	debug writeln("Destruction %s", properties[units[ i].typ].typName);
      }
    }
    units.length= units.length - offset;
    this.count= this.count - offset;
    advance();
  }
  void combine( uint runs){
    int target= position - runs + 1;
    for( int i= 0; i <= UT.max; i++){
      for( int j= target + 1; j < position; j++)
         data[ target].data[ i]+= data[ j].data[i];
    }
    if( runs > 1)
      position= target + 1;
    for( int i= 0; i <= UT.max; i++){
      data[ position].data[i]=0;
    }
    data[  position].count= 0;
  }
  void span(){
    advance();
    advance();
    uint[] arr; arr.length= position - 2;
    for( int i= 0; i < UT.max; i++){
      for( int j= 0; j< position - 2; j++){
        arr[ j]= data[ j].data[ i];
      }
      arr.sort;
      data[ position -2].data[ i]=  arr[ 1 + cast(int)(arr.length / 6.0 +0.5)];
      data[ position -1].data[ i]=  arr[ arr.length - cast(int)(arr.length / 6.0 +0.5)];
      debug writeln("span= %d .. %d", data[ position-2].data[ i],data[ position-1].data[ i]);
    }
  }
  import std.stdio;
  void print(){
    for( int i= 0; i <= UT.max; i++){
      write( "%s ", properties[ i].typName);
      for( int j= 0; j <= position; j++){
	write("%d ", data[ j].data[ i]);
      }
      writeln;
    }
  }
  void advance(){
    data.length= data.length + 1;
    position++;
    for( int i= 0; i <= UT.max; i++){
      data[ position].data[i]=0;
    }
    data[ position].count= 0;
  }
}

struct Unit{
  UnitType typ;
  WSH property;
  //bit destructed;
}

string[] outputs;

class Units{
  Unit[] data;
  Unit opIndex( uint idx){
    return data[ idx];
  }
  Unit* ptr( uint idx){
    return &data[ idx];
  }
  Unit opIndexAssign( Unit value, uint idx){
    data[ idx]= value;
    return value;
  }
  uint length(){
    return data.length;
  }
  uint length( uint value){
    data.length= value;
    return value;
  }
  this( WSH wsh, UnitCount unitCount){
    debug printf( "count=%d\n", unitCount.count);
    length= unitCount.count;
    int pos= 0;
    debug printf( "pos=");
    for( int i= 0; i< UT.max; i++){
      for( int j= 1; j <= unitCount[ i]; j++){
	debug printf( " %d", pos);
        data[ pos].typ= cast(UnitType)i;
	data[ pos].property.weapon= 
	  properties[ i].weapon * wsh.weapon;
	data[ pos].property.shield= properties[ i].shield * wsh.shield;
	data[ pos].property.hull= properties[ i].hull * wsh.hull;
	pos++;      
      }
    }
    debug printf( "\n");
  }
  void transformCU( UnitCount unitCount){
    for( UT unitType= UT.min; unitType <= UT.max; unitType++){
      if( unitCount[ unitType]){
	uint base= data.length - 1;
	data.length= data.length + unitCount[ unitType];
	for( int i= 1; i<= unitCount[ unitType]; i++){
	  data[ base + i].typ= unitType;
	}
      }
      debug printf( "now %d units\n", units.length);
    }
  }
  void transformUC( out UnitCount unitCount){
    for( int i= 0; i < data.length; i++){
      unitCount[ data[ i].typ]= unitCount[ data[ i].typ] + 1;
    }
  }
  void sort(){
    UnitCount unitCount= new UnitCount;
    debug print( data);
    transformUC( unitCount);
    data.length= 0;
    transformCU( unitCount);
    debug print( data);
  }
  import std.stdio;
  void print(){
    string output;
    for( int i=0; i< data.length; i++){
      output~= properties[data[ i].typ].typName ~ " ";
      write( "%s", properties[data[ i].typ].typName ~ " ");
    }
    outputs.length= outputs.length + 1;
    outputs[ outputs.length -1]= output;
    writeln;
  }
}

struct Loss{
  real metal=0, crystal=0, deut=0;
};


RapidFire rapidFire;

class ResultCount{
  uint[ 3] data;
  //Loss loss;
  this(){
    for( int i= 0; i < 3; i++) data[i]=0;
  };
  uint opIndex( int i){
    return data[ i + 1];
  }
  uint opIndexAssign( int value, uint i){
    data[ i + 1]= value;
    return value;
  }
};

import std.math:floor;
// one shot exclusive rapid fire
void shoot( Unit sender, ref Unit receiver){
  double w= sender.property.weapon;
  double s= receiver.property.shield;
  double h= receiver.property.hull;
  void subtract( ref double var, double value){
    var-= value;
    var= floor( var + .5L);
  }
  debug printf("shoot: %d -> %d\n", sender.typ, receiver.typ);

  if( w >= 0.01L * s){
    real damage= s<=0.0L
	       ? w
	       : ( floor( (w * 100.0L) / s) * s) / 100.0L;
    if( w > s){
      receiver.property.shield= 0.0L;
      subtract( receiver.property.hull,  damage - s);
    } else {
      subtract( receiver.property.shield, damage);
    }
  }
}

// one shot inclusive rapid fire
void shoots( ref Units sender, ref Units receiver, ref uint rapids){
  for( int i= 0; i< receiver.length; i++){
    receiver[ i].property.shield= properties[ receiver[ i].typ].shield;
  }

  for( int i= 0; i< sender.length; i++){
    uint choosen= cast(int)( floor(random() * receiver.length));
    debug printf( "choosen= %d\n", choosen);
    //Unit* sp= sender.ptr( i);
    Unit* rp= receiver.ptr( choosen);
    shoot( sender[ i], *rp);
    while( rapidFire( sender[ i].typ, (*rp).typ)){
      rapids++;
      choosen= cast(int)( floor( random() * receiver.length));
      debug printf( "choosenRapid= %d\n", choosen);
      rp= receiver.ptr( choosen);
      shoot( sender[ i], *rp);
    }
  }

}



class Destructed{
  UnitCount attacker, defender;
  this(){
    attacker= new UnitCount;
    defender= new UnitCount;
  }
  void opDiv( uint divisor){
    attacker / divisor;
    defender / divisor;
  }
  void combine( uint runs){
    attacker.combine( runs);
    defender.combine( runs);
  }
  void span(){
    attacker.span();
    defender.span();
    printf("inspan\n");
  }
  void print(){
    printf( "attacker:\n");
    attacker.print();
    printf( "defender:\n");
    defender.print();
  }
}
class Rapids{
  uint attacker= 0, defender= 0;
}

// one round
//void round( inout Units attacker, inout Units defender, inout Loss loss){
void round( ref Units attacker, ref Units defender,
	    ref Destructed destructed, ref Rapids rapids){ Loss loss;
  // TODO es gibt einen access error wenn man diesen paranmmetr �mmt

  debug print( attacker);
  debug print( defender);
  shoots( attacker, defender, rapids.attacker);
  shoots( defender, attacker, rapids.defender);
  destructed.defender.remove( defender);
  destructed.attacker.remove( attacker);
}

// a fight up to six rounds
//int fight( inout Units attacker, inout Units defender, inout Loss loss){
int fight( WSH awsh, UnitCount attacker,
	   WSH dwsh, UnitCount defender,
	   ref Destructed destructed, ref Rapids rapids){ static Loss loss;
  Units att= new Units( awsh, attacker);
  Units def= new Units( dwsh, defender);
  int i;
  for( i= 1; i<= 6 && att.length > 0 && def.length > 0; i++){
    //round( attacker, defender, loss);
    round( att, def, destructed, rapids);
  }
  destructed.combine( i);
  debug print( def);
  if( att.length > 0 && def.length > 0)
    return 0;
  else
    return att.length == 0  ? 1 : -1;
}

ResultCount simulate( uint count, bool max,
		 WSH awsh, UnitCount attacker,
		 WSH dwsh, UnitCount defender,
		 ref Destructed destructed, ref Rapids rapids){
  ResultCount resultCount= new ResultCount;
  //static Loss sloss={ 0, 0, 0};
  //Loss loss= sloss;

  for( int i=1; i<= count && ( !max || resultCount[ -1] == i - 1); i++){
    //int r= fight( att, def, loss);
    int r= fight( awsh, attacker, dwsh, defender, destructed, rapids);
    debug printf( "result= %d\n", r);
    resultCount[ r]= resultCount[ r] + 1;
    debug printf( "resulCount[ result]= %d\n", resultCount[ r]);
  }
  //result.loss.metal= loss.metal / count;
  //result.loss.crystal= loss.crystal / count;
  //result.loss.deut= loss.deut / count;
  return resultCount;
}



import std.stream:File;
import std.regex;
import std.utf;
import std.stdio;
import std.conv;
int mainn(){
  rapidFire= new RapidFire;
  real risk; uint runs, finalRuns, threshold;

  void readUnits4( string fileName, out UnitCount unitCount, out WSH wsh, out uint runs, out uint threshold){
    debug printf("[readUnits4 \n");
    auto scan = new File( fileName);
    unitCount= new UnitCount;
    string line;
    string[] fields;
    auto tab= regex( "\t");
    auto space= regex( "(\t|[ ])+");
    outputs.length= 0;
    bool isNumber(string s){
      int i;
      if( !s.length) return false;
      for( i= 0; i < s.length && std.ascii.isDigit(s[i]); i++){}
      return i == s.length;
    }
    runs= 10;

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
          writeln("field is\"%.*s\"\n", fields[i]);
          if( std.ascii.isAlphaNum( fields[ i][0]))
          if( name.length > 0)
            name~= " " ~ fields[ i].dup;
          else
            name= fields[ i].dup;
          writeln( "name now \"%.*s\"", name);
        } else {
            number= to!int(fields[i]);
            writeln("number is %d", number);
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
                debug printf("RIP\n");
                unitCount[ UT.RIP]= number;
                debug printf("RIP\n");
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
	      default:
                debug printf("default\n");
		outputs.length= outputs.length + 1;
		outputs[ outputs.length -1]= "\"" ~ name ~ "\"";
	    }
            name= "";
        }
      }
    }
    scan.close(); 
    // TODO if( runs < 1)runs=1;
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
    debug writeln("readUnits4]");
  }
  void readUnits2( string fileName, out UnitCount unitCount){
    WSH wsh;
    uint runs, threshold;
    readUnits4( fileName, unitCount, wsh, runs, threshold);
  }
  void readUnits3( string fileName, out UnitCount unitCount, out WSH wsh){
    uint runs, threshold;
    readUnits4( fileName, unitCount, wsh, runs, threshold);
  }
  static WSH awsh= { 1.7, 1.7, 1.7}, dwsh= { 1.7, 1.7, 1.7};
  UnitCount defender, attacker;
  UnitCount base;
  UnitCount reinforcement;

  writeln("scan");
  readUnits3( "scan.txt", defender, dwsh);
  writeln("praes");
  readUnits4( "praesent.txt", base, awsh, runs, threshold);
  writeln("nach");
  readUnits2( "nachschb.txt", reinforcement);
  writeln( "Dies ist Milkysim 0.1\n");

  writeln( "Du hast folgende Einheiten:\n");
  base.print();
  writeln( "Du hast folgendes als Nachschubkontingent bestimmt:\n");
  reinforcement.print();
  writeln( "Dein Gegner hat folgende Einheiten:\n");
  defender.print();
  uint x( real y){ return cast(int)( floor( (y-1)*10 + 0.5));}
  writeln( "Waffentechnik: Du= %d, Gegner= %d\n", x(awsh.weapon), x(dwsh.weapon));
  writeln( "Schildtechnik: Du= %d, Gegner= %d\n", x(awsh.shield), x(dwsh.shield));
  writeln( "Raumschiffpanzerung: Du= %d, Gegner= %d\n", x(awsh.hull), x(dwsh.hull));
  writeln( "%d von %d Simulationen muessen Sieg ergeben.\n",
           runs - threshold, runs);


  auto result= simulate( 1000, false, attacker, defender);
  write( "%d %d %d\n", result[ -1] ,result[ 0], result[ 1]);
  version( how){
  uint erg= howMuch( awsh, base, reinforcement,
                     runs, threshold,
                     dwsh, defender);
  writeln( "Du benoetigst %d-mal Dein Nachschubkontingent.\n", erg);
  writeln( "Druecke eine Taste um dieses Programm zu beenden.\n");
  version(win) {} else
  getchar();
  return erg;
  }
}


int main() {
  import std.stdio;
   int y=mainn();
   if( y == 0)
     writeln( "Ihre praesenten Einheiten reichen aus.");
   else
     writeln( "Sie benoetigen das Nachschubkontingent %d-mal", y);
   return 0;
}

/+
unittest {
  Unit sender, receiver;
  
  
  struct Set{
    UT st;
    double sw;
    UT rt;
    double rs, rh;
    double ress, resh;
  }
  static Set[10] set=[
  { UT.SS, 1.0L - double.epsilon, UT.SS, 100.0L, 100.0L, 100.0L, 100.0L},
  { UT.SS, 1.0L                 , UT.SS, 100.0L, 100.0L,  99.0L, 100.0L},
  { UT.SS, 1.0L + double.epsilon, UT.SS, 100.0L, 100.0L,  99.0L, 100.0L},
  { UT.SS, 100.0L - 100* double.epsilon, UT.SS, 100.0L, 100.0L,   1.0L, 100.0L}, 
  { UT.SS, 100.0L                      , UT.SS, 100.0L, 100.0L,   0.0L, 100.0L},
  { UT.SS, 100.0L + 100* double.epsilon, UT.SS, 100.0L, 100.0L,   0.0L, 100.0L},
  { UT.SS, 101.0L - 100* double.epsilon, UT.SS, 100.0L, 100.0L,   0.0L, 100.0L}, 
  { UT.SS, 101.0L                      , UT.SS, 100.0L, 100.0L,   0.0L,  99.0L},
  { UT.SS, 101.0L + 100* double.epsilon, UT.SS, 100.0L, 100.0L,   0.0L,  99.0L}];
     

 for( int i= 0; i < 9; i++){
    sender.typ= set[ i].st;;
    sender.property.weapon= set[ i].sw;
    receiver.typ= set[ i].rt;
    receiver.property.shield= set[ i].rs;
    receiver.property.hull= set[ i].rh;
    write("%s( %.2llf) -> %s( %.2llf, %.2llf)=",
      properties[ sender.typ].typName, sender.property.weapon, 
      properties[ receiver.typ].typName, receiver.property.shield, receiver.property.hull);
    shoot( sender, receiver);
    write("( %.2llf, %.2llf)\n",
      receiver.property.shield, receiver.property.hull);
    assert( receiver.property.shield == set[i].ress && receiver.property.hull == set[ i].resh);
 }
  
}
+/
/* vim:set nu sw=2 nowrap: */
