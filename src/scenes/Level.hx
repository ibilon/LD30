package scenes;

import com.haxepunk.Entity;
import com.haxepunk.Scene;
import com.haxepunk.tmx.*;

typedef Map = {
	var back : entities.Back;
	var player : entities.Player;
	var map : Entity;
	var size : Int;
	var end : entities.End;
}

class Level extends Scene
{
	var maps = new Array<Map>();
	
	public function new (id:Int)
	{
		super();
		
		load('maps/level_${id}_top.tmx', 0, "p1_");
		load('maps/level_${id}_bottom.tmx', 320, "p2_");
	}
	
	private function load (path:String, pos:Int, p:String)
	{
		var back = new entities.Back(p, pos);
		add(back);
		
		var map : TmxMap = new TmxMap(openfl.Assets.getText(path));
		var size = (map.width - 1) * 32;
		
		var map_e = new TmxEntity(map);
		map_e.y = pos;
		map_e.loadGraphic("graphics/tileset.png", ["layer"]);
		map_e.loadMask("collision", "solid");
		var map_e = add(map_e);
		
		var player : entities.Player = null;
		var end : entities.End = null;
		
		for(object in map.getObjectGroup("objects").objects)
		{
			switch (object.type)
			{
			case "player":
				add(player = new entities.Player(p, object.x, object.y + pos));
				
			case "end":
				add(end = new entities.End(p, object.x, object.y+pos));
				
			default:
				trace('Unknown type: "${object.type}"');
			}
		}
		
		maps.push({ back: back, player: player, map: map_e, size: size, end: end });
	}
	
	public override function update ()
	{
		super.update();
		
		var ended = true;
		
		for (m in maps)
		{			
			if (m.player.x < 320 && m.map.x < 0)
			{
				var offset = Math.max(320 - m.player.x, m.map.x);
				m.back.x += offset/2;
				m.player.x += offset;
				m.map.x += offset;
				m.end.x += offset;
			}
			if (m.player.x > 320 && m.map.x > 640 - m.size)
			{
				var offset = Math.max(m.player.x - 320, 640 - m.size - m.map.x);
				m.back.x -= offset/2;
				m.player.x -= offset;
				m.map.x -= offset;
				m.end.x -= offset;
			}
			
			ended = ended && m.player.onEnd;
		}
		
		if (ended)
		{
			trace("ended");
		}
	}
}
