package common;

class Common{
    public static function entierAleatoir(a:Int,b:Int):Int{ return a + Math.round(( b - a ) * Math.random()); }
    public static function _increment(a:Int,dir:Int,min:Int,max:Int):Int{
        if(dir>0){
            ++a;
			if(a>max) a = min;
        }
        else if(dir<0){
            --a;
            if(a<min) a = max;
        }
        return a;
    }
    public static function increment(a:Int,dir:Int,max:Int,min:Int=1):Int{
        ++a;
        a+=dir;
        if(a>max) a -= max;
        else if(a<min) a += max;
        return --a;
    }
}
class Rules{

}
typedef PPoint = {
	var x:Int;
	var y:Int;
}
