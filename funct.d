
import std.stdio;

import functionh;

struct Loss{
  real metal=0, crystal=0, deut=0;
};


RapidFire rapidFire;


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
  debug writef("shoot: %d -> %d\n", sender.typ, receiver.typ);

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
    real rnd= random();
    uint choosen= cast(int)( floor(rnd * receiver.length));
    debug writeln( rnd, " ", receiver.length);
    debug writefln( "choosen= %d", choosen);
    //Unit* sp= sender.ptr( i);
    Unit* rp= receiver.ptr( choosen);
    shoot( sender[ i], *rp);
    while( rapidFire( sender[ i].typ, (*rp).typ)){
      rapids++;
      choosen= cast(int)( floor( random() * receiver.length));
      debug writefln( "choosenRapid= %d\n", choosen);
      rp= receiver.ptr( choosen);
      shoot( sender[ i], *rp);
    }
  }

}


// one round
//void round( inout Units attacker, inout Units defender, inout Loss loss){
void round( ref Units attacker, ref Units defender,
	    ref Destructed destructed, ref Rapids rapids){ Loss loss;
  // TODO es gibt einen access error wenn man diesen paranmmetr �mmt

  debug writeln( "round: ", attacker);
  debug writeln( "round: ", defender);
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
  debug(now) writeln( att, "<>", def);
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
    debug(now) write( i, ": ");
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
/* vim:set nu sw=2 nowrap: */
