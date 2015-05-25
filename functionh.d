public import inputh;

import std.stdio;
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
    debug writeln("inspan");
  }
  void print(){
    writeln( "attacker:");
    attacker.print();
    writeln( "defender:");
    defender.print();
  }

}
class Rapids{
  uint attacker= 0, defender= 0;
}

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
  alias toString=Object.toString;
  override string toString(){
    writeln( data);
    return "";
  }
};

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


/* vim:set nu sw=2 nowrap: */
