package entities;

import com.haxepunk.Entity;

class End extends Entity
{
	var id : String;
	
	public function new (id:String, x:Float, y:Float)
	{
		super(x, y);
		this.id = id;
		type = "end";
		setHitbox(32, 32, 0, -32);
	}
}
