package;

#if desktop
import Discord.DiscordClient;
#end
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import lime.utils.Assets;
import haxe.Json;

#if FEATURE_FILESYSTEM
import Sys;
import sys.FileSystem;
#end


using StringTools;


typedef CreditsFile ={
	var peeps:Array<Peeps>;
	var listoroles:Array<String>;
}

typedef Peeps = {
	var realName:String;
	var iconName:String;
	var description:String;
	var twitter:String;
	var whichrole:Int;
	var funnyName:String;
	var hiddenType:String;
}

class CustomCreditsState extends MusicBeatState
{
	var backdrop:FlxBackdrop;
	static var backdropX:Float = 0;
	
	var curSelected:Int = 0;
	static var curPage:Int = 0;
	static var pageFlipped:Bool = false;

	var rolelist:Array<String> = [];
	
	private var grpNames:FlxTypedGroup<FlxText>;
	private var iconArray:Array<FlxSprite> = [];

	var funnyName:FlxText;
	var funnyDesc:FlxText;

	//hueh
	public var bufferArray:Array<Peeps> = [];
	var creditsStuff:Array<Array<Dynamic>> = [];

	override function create()
	{
	    #if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Credits Menu", null);
		#end

		persistentUpdate = persistentDraw = true;

		if (pageFlipped)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			pageFlipped = false;
		}
		else
		{
		FlxG.sound.playMusic(Paths.music('cutscene-together-whenever'), 1, true);
		}
		
		backdrop = new FlxBackdrop(Paths.image('credits/scrollingBG'));
		backdrop.x = backdropX;
		backdrop.velocity.set(-16, 0);
		backdrop.scale.set(0.2, 0.2);
		backdrop.antialiasing = ClientPrefs.globalAntialiasing;
		add(backdrop);
		
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('credits/background'));
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		var path:String = 'why';
		path = Paths.getPreloadPath('images/credits/credits' + '-' + ClientPrefs.language +'.json');

		var rawJson = Assets.getText(path);
		var json:CreditsFile = cast Json.parse(rawJson);


		rolelist = json.listoroles;
		bufferArray = json.peeps;
		
		for (peep in bufferArray)
		{
			if (peep.whichrole == curPage)
			{
				if ((peep.hiddenType == 'vsand' && !StoryMenuState.weekCompleted.get('andweek1'))
		//			||(peep.hiddenType == 'vsandsecretsong' && !Paths.formatToSongPath(SONG.song) == 'andstranomical-countdown')
					||(peep.hiddenType == 'vsfriends' && !StoryMenuState.weekCompleted.get('friendsweek2'))
       //             ||(peep.hiddenType == 'vsfriendssecretsong' && !Paths.formatToSongPath(SONG.song) == 'tesuto')
					||(peep.hiddenType == 'vsgf' && !StoryMenuState.weekCompleted.get('tutorialremix')))
					continue;
					
				creditsStuff.push([peep.realName, peep.iconName, peep.description, peep.twitter, peep.whichrole, peep.funnyName]);
			}
		}


		grpNames = new FlxTypedGroup<FlxText>();
		add(grpNames);

		for (i in 0...creditsStuff.length)
		{
			//Text names
			var nameText:FlxText = new FlxText(252, 196 + (i * 43), 500, creditsStuff[i][0], 9);
			nameText.setFormat(Paths.font("funkin.ttf"), 27, FlxColor.WHITE, FlxTextAlign.LEFT);
			nameText.antialiasing = ClientPrefs.globalAntialiasing;
			nameText.borderStyle = OUTLINE;
			nameText.borderColor = 0xFFEB489C;
			nameText.ID = i;
			grpNames.add(nameText);
		}

		for (i in 0...creditsStuff.length)
		{
			//icons
			var icon:FlxSprite = new FlxSprite(770, 180).loadGraphic(Paths.image('credits/icons/' + creditsStuff[i][1]));

			if (!Paths.fileExists('images/credits/icons/' + creditsStuff[i][1] + '.png', IMAGE))
				icon.loadGraphic(Paths.image('credits/icons/default'));

			iconArray.push(icon);
			icon.antialiasing = ClientPrefs.globalAntialiasing;
			icon.scale.set(1.5, 1.5);
			icon.updateHitbox();
			add(icon);
		}

		funnyName = new FlxText(286, 424, 1180, "", 50);
		funnyName.setFormat(Paths.font("funkin.ttf"), 50, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, 0xFFFF00FF);
		funnyName.scrollFactor.set();
		funnyName.borderSize = 2.4;
		funnyName.antialiasing = ClientPrefs.globalAntialiasing;
		add(funnyName);

		funnyDesc = new FlxText(286, 550, 1180, "", 20);
		funnyDesc.setFormat(Paths.font("funkin.ttf"), 20, 0xFFFF00FF, CENTER);
		funnyDesc.scrollFactor.set();
		funnyDesc.borderSize = 1;
		funnyDesc.antialiasing = ClientPrefs.globalAntialiasing;
		add(funnyDesc);

		var fg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('credits/overlay'));
		fg.antialiasing = ClientPrefs.globalAntialiasing;
		add(fg);

		var modRoleText:FlxText = new FlxText(50, 60, 1180, rolelist[curPage], 60);
		modRoleText.setFormat(Paths.font("Phantomuff Difficult Font.ttf"), 60, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, 0xFFFF00FF);
		modRoleText.borderSize = 2.5;
		modRoleText.screenCenter(X);
		modRoleText.antialiasing = ClientPrefs.globalAntialiasing;
		add(modRoleText);
		
		if (StoryMenuState.weekCompleted.get('friendsweek2'))
		{
		var cutscenebutton = new FlxSprite().loadGraphic(Paths.image('credits/wheneverb' + '-eu'/* + ClientPrefs.language + ".png"*/));		
		cutscenebutton.scrollFactor.set();
	//	cutscenebutton.setGraphicSize(Std.int(cutscenebutton.width * 1.175));
		cutscenebutton.updateHitbox();
	    cutscenebutton.screenCenter();
		add(cutscenebutton); // cutscene jaja
		}

		changeSelection();

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
	//	var l = FlxG.keys.justPressed.L;

		if (FlxG.sound.music.volume < 0.8)
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;

		if (!selectedSomethin)
		{
		    if (FlxG.keys.justPressed.L && StoryMenuState.weekCompleted.get('friendsweek2'))
			{
				persistentUpdate = false;
				FlxG.sound.play(Paths.themeSound('confirmMenu'));
				FlxG.switchState(new BayBayOldGame());	 // gamejolt 2 jaja				
			 }
			  
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeSelection(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeSelection(1);
			}

			if (controls.UI_LEFT_P)
			{
				changePage(-1);
			}

			if (controls.UI_RIGHT_P)
			{
				changePage(1);
			}
			
			if (controls.ACCEPT)
			{
			      if (creditsStuff[curSelected][3] != '')
				{
					CoolUtil.browserLoad(creditsStuff[curSelected][3]);
				}
			}

			if (controls.BACK)
			{
				curPage = 0;
                FlxG.sound.playMusic(Paths.music("freakyMenu"));
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
			}
		}

		super.update(elapsed);
	}

	function changeSelection(change:Int = 0)
	{
		curSelected += change;
		var bullShit:Int = 0;

		if (curSelected >= creditsStuff.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = creditsStuff.length - 1;

		trace(curSelected);

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0;
		}
		if (iconArray.length > 0)
			iconArray[curSelected].alpha = 1;

		for (item in grpNames.members)
		{
			item.ID = bullShit - curSelected;
			bullShit++;

			FlxTween.cancelTweensOf(item);

			if (curSelected >= 6 && curSelected <= creditsStuff.length - 4)
				FlxTween.tween(item, {y: 454 + (item.ID * 43)}, 0.5, {ease: FlxEase.circOut});

			if (curSelected <= 5)
			{
				FlxTween.cancelTweensOf(item);

				if (curSelected == 0)
					FlxTween.tween(item, {y: 196 + (item.ID * 43)}, 0.5, {ease: FlxEase.circOut});
				if (curSelected == 1)
					FlxTween.tween(item, {y: 239 + (item.ID * 43)}, 0.5, {ease: FlxEase.circOut});
				if (curSelected == 2)
					FlxTween.tween(item, {y: 282 + (item.ID * 43)}, 0.5, {ease: FlxEase.circOut});
				if (curSelected == 3)
					FlxTween.tween(item, {y: 325 + (item.ID * 43)}, 0.5, {ease: FlxEase.circOut});
				if (curSelected == 4)
					FlxTween.tween(item, {y: 368 + (item.ID * 43)}, 0.5, {ease: FlxEase.circOut});
				if (curSelected == 5)
					FlxTween.tween(item, {y: 411 + (item.ID * 43)}, 0.5, {ease: FlxEase.circOut});
			}

			if (creditsStuff.length >= 10 && curSelected >= creditsStuff.length - 4)
			{
				FlxTween.cancelTweensOf(item);

				if (curSelected == creditsStuff.length - 4)
					FlxTween.tween(item, {y: 454 + (item.ID * 43)}, 0.5, {ease: FlxEase.circOut});
				if (curSelected == creditsStuff.length - 3)
					FlxTween.tween(item, {y: 497 + (item.ID * 43)}, 0.5, {ease: FlxEase.circOut});
				if (curSelected == creditsStuff.length - 2)
					FlxTween.tween(item, {y: 540 + (item.ID * 43)}, 0.5, {ease: FlxEase.circOut});
				if (curSelected == creditsStuff.length - 1)
					FlxTween.tween(item, {y: 583 + (item.ID * 43)}, 0.5, {ease: FlxEase.circOut});
			}

			item.setBorderStyle(OUTLINE, 0xFFEB489C, 1, 1);

			if (item.ID == 0)
				item.setBorderStyle(OUTLINE, 0xFFFFA7F3, 1, 1);
		}

		if(creditsStuff[curSelected][5] != null)
			Paths.currentModDirectory = creditsStuff[curSelected][5];
		else
			funnyName.text = creditsStuff[curSelected][0];
		funnyDesc.text = creditsStuff[curSelected][2];
		funnyDesc.y = funnyName.y + funnyName.height;
	}

	function changePage(change:Int = 0)
	{
		pageFlipped = true;
		curPage += change;

		if (curPage >= rolelist.length)
			curPage = 0;
		if (curPage < 0)
			curPage = rolelist.length - 1;

		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		LoadingState.loadAndSwitchState(new CustomCreditsState(), false);
	}
}