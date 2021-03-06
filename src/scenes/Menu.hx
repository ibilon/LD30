package scenes;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Input;

class Menu extends Scene
{
	var top : Entity;
	var bottom : Entity;
	var button : Entity;
	
	public override function begin ()
	{
		var topB = new Backdrop("graphics/p1_back.png", true, false);
		var bottomB = new Backdrop("graphics/p2_back_r.png", true, false);
		
		top = addGraphic(topB, 0, 320, 320);
		bottom = addGraphic(bottomB, 0, 0, 0);
		
		var title = new Image("graphics/title.png");
		addGraphic(title, 0, 120, (320 - title.height) / 2);
		
		var play = new Image("graphics/play.png");
		button = addGraphic(play, 0, (640 - play.width) / 2, 320 - (play.height / 2));
		button.setHitboxTo(play);
		
		var credits = new Text("A game made in 48h for Ludum Dare 30\nby Valentin Lemiere", { size: 30, align: flash.text.TextFormatAlign.CENTER, color: 0 });
		addGraphic(credits, 0, (640 - credits.width) / 2, 540);
	}
	
	public override function update ()
	{
		super.update();
		
		top.x += 50 * HXP.elapsed;
		bottom.x += 50 * HXP.elapsed;
		
		if (button.collidePoint(button.x, button.y, Input.mouseX, Input.mouseY))
		{
			cast(button.graphic, Image).color = 0xffe8c4;
			
			if (Input.mouseReleased)
			{
				HXP.scene = new scenes.Level(1);
			}
		}
		else
		{
			cast(button.graphic, Image).color = 0xFFFFFF;
		}
	}
}
