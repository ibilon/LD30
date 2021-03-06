package scenes;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.tmx.*;

typedef Map = {
	var back : entities.Back;
	var player : entities.Player;
	var map : Entity;
	var size : Int;
	var end : entities.End;
	var other : Array<Entity>;
}

class Level extends Scene
{
	static inline var MAX_LEVEL = 2;
	var maps = new Array<Map>();
	var id : Int;
	
	public function new (id:Int)
	{
		super();
		
		this.id = id;
		
		load('maps/level_${id}_top.tmx', 0, "p1_");
		load('maps/level_${id}_bottom.tmx', 320, "p2_");
		
		var level = new Text('Level ${id}', { size: 30, color: 0 });
		addGraphic(level, 0, (640 - level.width) / 2, 320 - (level.height / 2));
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
		var other = new Array<Entity>();
		
		for(object in map.getObjectGroup("objects").objects)
		{
			switch (object.type)
			{
			case "player":
				add(player = new entities.Player(p, object.x, object.y + pos));
				
			case "end":
				add(end = new entities.End(p, object.x, object.y+pos));
			
			case "image":
				other.push(addGraphic(new Image('graphics/${object.name}'), 0, object.x, object.y + pos));
				
			default:
				trace('Unknown type: "${object.type}"');
			}
		}
		
		maps.push({ back: back, player: player, map: map_e, size: size, end: end, other: other });
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
				
				for (o in m.other)
				{
					o.x += offset;
				}
			}
			if (m.player.x > 320 && m.map.x > 640 - m.size)
			{
				var offset = Math.max(m.player.x - 320, 640 - m.size - m.map.x);
				m.back.x -= offset/2;
				m.player.x -= offset;
				m.map.x -= offset;
				m.end.x -= offset;
				
				for (o in m.other)
				{
					o.x += offset;
				}
			}
			
			ended = ended && m.player.onEnd;
		}
		
		if (ended)
		{
			if (id < MAX_LEVEL)
			{
				HXP.scene = new scenes.Level(id + 1);
			}
			else
			{
				HXP.scene = new scenes.EndScreen();
			}
		}
	}
}
