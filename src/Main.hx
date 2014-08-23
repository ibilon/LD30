import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Main extends Engine
{
	public function new ()
	{
		super(640, 640, 60, false);
	}
	
	override public function init ()
	{
		#if debug HXP.console.enable(Key.SPACE); #end
		
		Input.define("p1_UP", [Key.Z, Key.W]);
		Input.define("p1_LEFT", [Key.Q, Key.A]);
		Input.define("p1_DOWN", [Key.S]);
		Input.define("p1_RIGHT", [Key.D]);
		
		Input.define("p2_UP", [Key.UP]);
		Input.define("p2_LEFT", [Key.LEFT]);
		Input.define("p2_DOWN", [Key.DOWN]);
		Input.define("p2_RIGHT", [Key.RIGHT]);
		
		HXP.scene = new scenes.Level(2);
	}

	public static function main ()
	{
		new Main();
	}
}
