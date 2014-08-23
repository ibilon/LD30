package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Backdrop;

class Back extends Entity
{
	public function new (id:String, pos:Int)
	{
		super(0, pos);
		
		graphic = new Backdrop('graphics/${id}back.png', true, false);
	}
}
