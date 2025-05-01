package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.text.FlxText;

using StringTools;

class HeyMessage extends MusicBeatSubstate
{
	var popupID:Int = 0;

	var popupData:Array<Array<Dynamic>> = [
		['and', ['RealityAnd', 'Countdown']],
		['friends', ['RealityFriends', 'AndEclipsed', 'Test', 'Credits']]
	];

	var popupStyles:Array<Array<Dynamic>> = [
		['Epiphany', 'epiphany'],
		['Lyrics', 'epiphany'],
		['VA11HallA', 'va11halla'],
		['Libitina', 'libitina']
	];

	var state:String = 'story';
	var style:String = 'normal';
	var type:String = 'Prologue';

	var box:FlxSprite;
	var text:FlxText;
	var popupText:String = 'Just Monika.';

	public function new(type:String, state:String = 'story')
	{
		super();

		this.state = state.toLowerCase();
		this.type = type;

		switch (this.state)
		{
			case 'story':
				StoryMenuState.instance.acceptInput = false;
			case 'freeplay':
				FreeplayState.instance.acceptInput = false;
		}

		for (i in 0...popupData.length)
		{
			if (popupData[i][0] != type.toLowerCase())
				continue;

			popupID = i;
		}

		var background:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
		background.alpha = 0.5;
		add(background);

		box = new FlxSprite();
		box.frames = Paths.getSparrowAtlas('dokistory/popup', 'preload');
		box.animation.addByPrefix('normal', 'normal');
		box.animation.play('normal');
		box.antialiasing = SaveData.globalAntialiasing;
		box.screenCenter();
		box.offset.set(-71);
		add(box);

		text = new FlxText(0, box.y + 76, box.frameWidth * 0.95, popupText);
		text.setFormat(LangUtil.getFont('aller'), 32, FlxColor.BLACK, FlxTextAlign.CENTER);
		text.y += LangUtil.getFontOffset('aller');
		text.screenCenter(X);
		text.antialiasing = SaveData.globalAntialiasing;
		add(text);

		FlxG.sound.play(Paths.sound('scrollMenu'));
		updateBox();
	}

	function updateBox():Void
	{
		popupText = 'msg' + popupData[popupID][1][0], 'story';

		for (i in 0...popupStyles.length)
		{
			if (popupStyles[i][0] != popupData[popupID][1][0])
				continue;

			style = popupStyles[i][1].toLowerCase();
		}

		switch (style)
		{
			default:
				if (!FlxG.sound.music.playing)
				{
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
					Conductor.changeBPM(120);
				}

				text.setFormat(LangUtil.getFont('aller'), 32, FlxColor.BLACK, FlxTextAlign.CENTER);
				text.antialiasing = SaveData.globalAntialiasing;
				box.animation.play('normal');
				box.offset.set(-71);
				box.antialiasing = SaveData.globalAntialiasing;

				text.setFormat(LangUtil.getFont('dos'), 32, FlxColor.WHITE, FlxTextAlign.CENTER);
				text.y += 20;
				text.antialiasing = false;
				box.animation.play('libitina');
				box.offset.set(-71);
				box.antialiasing = SaveData.globalAntialiasing;
		}

		text.text = popupText;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));

			popupData[popupID][1].remove(popupData[popupID][1][0]);

			if (popupData[popupID][1].length > 0)
			{
				updateBox();
			}
			else
			{
				Reflect.setProperty(SaveData, 'popup' + type, true);
				SaveData.save();

				switch (state)
				{
					case 'story':
					{
						StoryMenuState.showPopUp = false;
						StoryMenuState.instance.acceptInput = true;
					}
					case 'freeplay':
					{
						FreeplayState.showPopUp = false;
						FreeplayState.instance.acceptInput = true;
					}
				}

				if (!FlxG.sound.music.playing)
				{
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
					Conductor.changeBPM(120);
				}

				close();
			}
		}
	}

	public static function checkStatus(data:String):Bool
	{
		return Reflect.getProperty(SaveData, 'popup' + data);
	}
}