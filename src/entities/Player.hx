package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;

class Player extends Entity
{
	var id : String;
	var coll =  ["solid"];
	public var onEnd(default, null) = false;
	
	var HSPEED:Int = 200;
	var GRAVITY:Int = 4;
	var JUMP:Int = 200;	
	var vy:Float = 0;
	var inJump:Bool = true;
	
	public function new (id:String, x:Float, y:Float)
	{
		super(x, y);
		this.id = id;
		type = "player";
		
		graphic = new Image('graphics/${id}player.png');
		setHitbox(40, 40);
	}
	
	override public function update ()
	{
		var img = cast(graphic, Image);
		
		// Player input.
		var hInput:Int = 0;		
		if(Input.check('${id}LEFT')) { img.scaleX = -1; img.x = img.width; hInput -= 1; }
		if(Input.check('${id}RIGHT')) { img.scaleX = 1; img.x = 0; hInput += 1; }
		if(Input.pressed('${id}UP') && !inJump) { vy = -JUMP; inJump = true; }
		
		// Update physics.
		vy += GRAVITY;
		
		// Apply physics.		
		moveBy(HSPEED * hInput * HXP.elapsed, vy * HXP.elapsed, coll);
		
		if (x < 0)
		{
			x = 0;
		}
		
		onEnd = (collide("end", x, y) != null);
		
		if (onEnd)
		{
			img.color = 0xAAAA00;
		}
		else
		{
			img.color = 0xFFFFFF;
		}
	}
	
	override public function moveCollideX (e:Entity) { return moveCollideBy(e, "X"); }
	override public function moveCollideY (e:Entity) { return moveCollideBy(e, "Y"); }	
	private function moveCollideBy (e:Entity, dir:String)
	{
		switch (e.type)
		{			
		case "solid":
			if (dir == "Y")
			{			
				if (vy > 0) 
				{
					inJump = false;
					vy = 0;
				}
			}
		}
			
		return true;
	}
}
