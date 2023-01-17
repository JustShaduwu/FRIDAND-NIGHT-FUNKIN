package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class TestandState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var uwuText:FlxText;
	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		uwuText = new FlxText(0, 0, FlxG.width,
			"Hey, estas jugando una Beta De FRIDAND NIGHT FUNKIN' VS ANDSHADOW'S, \n
			y aunque esta version es muy cercana a el producto final \n
			algunas cosas pueden modificarse para la version final \n
		  	               Gracias por jugar ^v^!",
			32);
		uwuText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		uwuText.screenCenter(Y);
		add(uwuText);
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			if(controls.ACCEPT) {
				leftState = true;
			}

			if(leftState)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxTween.tween(uwuText, {alpha: 0}, 1, {
					onComplete: function (twn:FlxTween) {
						MusicBeatState.switchState(new MainMenuState());
					}
				});
			}
		}
		super.update(elapsed);
	}
}
