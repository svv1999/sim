import std.math:floor;
import std.math:pow;
//uint runs= 10, threshold= 0;
//uint finalRuns= 100;
real risk= 0.05L;

real fac( real n){
  n= floor( n +.5L);
  real retval= 1.0L;
  for(real i= 1.0L; i<= n; i++){
    retval*= cast(real)i;
  }
  return retval;
}
real over( real n, real k){
  n= floor( n +.5L);
  k= floor( k +.5L);
  return (( 1.0L / fac( n - k)) * fac( n)) / fac( k);
}
// Wahrscheinlichkeit das man bei n Versuchen bis zu k mal Erfolg hat
// wenn p die Erfolgswahrscheinlichkeit für ein einzelnes Ereignis ist
real fpnk( real p, real n, real k){
  n= floor( n +.5L);
  k= floor( k +.5L);
  real retval= 0.0L;
  for( real i= 0.0L; i <= k; i++){
     retval+= (over( n, i) * pow( p, i)) * pow(1.0L- p, n - i);
  }
  return retval;
}
uint anz( uint n, real p){
  // Berechne k so, dass fpnk for p und n gerade eben oberhalb
  //   des signifikanzniveaus ist
  real s=p>0.01L?0.05L:0.01L;
  uint k;
  for( k=0; k<=n&&fpnk( p, n, k)<s; k++){
    debug writefln("%f", fpnk( p, n, k));
  }
  return k;
}
import std.stdio;
unittest{
  debug writefln( "%d", anz( 58, 0.05L));
  // remark:
  // 58 is the highest number so that
  // zero fails are allowed for 5%
  assert( anz( 1000, 0.05L) == 39);
  // Interpretation:
  // when 39 or more tries out of 1000 fail
  // then the assumption is true, that the probability
  // of fail is at least 5%
}
/* vim:set nu sw=2 nowrap: */
