package scenes;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;

class EndScreen extends Scene
{
	var top : Entity;
	var bottom : Entity;
	
	public override function begin ()
	{
		var topB = new Backdrop("graphics/p1_back.png", true, false);
		var bottomB = new Backdrop("graphics/p2_back_r.png", true, false);
		
		top = addGraphic(topB, 0, 320, 320);
		bottom = addGraphic(bottomB, 0, 0, 0);
		
		var title = new Image("graphics/title.png");
		addGraphic(title, 0, 120, 100);
		
		var end = new Text("You completed all the levels!\n\nThanks for playing my game :)", { size: 42, align: flash.text.TextFormatAlign.CENTER, color: 0 });
		addGraphic(end, 0, (640 - end.width) / 2, 320 - (end.height / 2));
		
		var credits = new Text("A game made in 48h for Ludum Dare 30\nby Valentin Lemiere", { size: 30, align: flash.text.TextFormatAlign.CENTER, color: 0 });
		addGraphic(credits, 0, (640 - credits.width) / 2, 540);
	}
	
	public override function update ()
	{
		super.update();
		
		top.x += 50 * HXP.elapsed;
		bottom.x += 50 * HXP.elapsed;
	}
}
