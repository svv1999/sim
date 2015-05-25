import std.stdio;
import std.conv;

enum UnitType {KT, GT,
           LJ, SJ, KREUZER, SS, KOLO, RECY, SPIO,
           BOMBER, SOLAR, ZERSTOERER, RIP, SK,
           RAK, LL, SL, GAUSS, ION, PLASMA,
           KS, GS};
alias UnitType UT;

struct Unit{
  UnitType typ;
  WSH property;
  //bit destructed;
}

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
{ UC.DEF,  "GS", 1, 10000, 10000, 50000, 50000, 0, 0}, //GS
];


  import std.random:rndGen;
  real random(){
    rndGen.popFront;
    return cast(real)rndGen.front/uint.max;
  }
unittest{
  assert( random() != random());
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
      debug writeln( "now %d units", data.length);
    }
  }
  void transformUC( out UnitCount unitCount){
    for( int i= 0; i < data.length; i++){
      unitCount[ data[ i].typ]= unitCount[ data[ i].typ] + 1;
    }
  }
  void sort(){
    UnitCount unitCount= new UnitCount;
    debug writeln( data);
    transformUC( unitCount);
    data.length= 0;
    transformCU( unitCount);
    debug writeln( data);
  }
  string print(){
    string output;
    for( int i=0; i< data.length; i++){
      output~= properties[data[ i].typ].typName ~ " ";
      debug writef( "%s", properties[data[ i].typ].typName ~ " ");
    }
    outputs.length= outputs.length + 1;
    outputs[ outputs.length -1]= output;
    debug writeln;
    return output;
  }
  alias toString= Object.toString;
  override string toString(){
    string output;
    uint[ UnitType.max+1] count;
    for( int i=0; i< data.length; i++){
      count[data[ i].typ]++;
      debug writef( "%s", properties[data[ i].typ].typName ~ " ");
    }
    for( int i=0; i< properties.length; i++){
      if( count[i]) output~= properties[ i].typName ~ " "
                           ~ to!string( count[i]) ~ "\n";
    }
    return output;
    //return print();
  }

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
	debug writefln("Destruction %s", properties[units[ i].typ].typName);
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
      writef( "%s ", properties[ i].typName);
      for( int j= 0; j <= position; j++){
	writef("%d ", data[ j].data[ i]);
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
  alias toString= Object.toString;
  override string toString(){
    print();
    return "";
  }
}
/* vim:set nu sw=2 nowrap: */
