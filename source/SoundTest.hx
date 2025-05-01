package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.util.FlxTimer;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.transition.FlxTransitionableState;
#if MODS_ALLOWED
import sys.io.File;
import sys.FileSystem;
#end

using StringTools; // adds support for endsWith and shit

class SoundTest extends MusicBeatState
{
    var songs:Array<String> = [];
    var enems:Array<String> = ['gf'];
    var songOrder:Array<String> = [''];
    var hasBf:Map<String, Bool> = new Map();
    var hasVoltz:Map<String, Bool> = new Map();
    var defDir:Map<String, Bool> = new Map();
    var showVoiceUI:Map<String, Bool> = new Map();
    var char:Map<String, String> = new Map();
    var skipPaths:Array<String> = ['readme.txt'];
    
    var curSelected:Int = 0;
    var curSelectedPlaying:Int = 0;
    public static var liveofs:Float = 0;
    var curSong:String = 'bopeebo';
    public static var songPlaying:Bool = false;
    var scalethingy:Float = 0.2;
	private var grpSongs:FlxTypedGroup<Alphabet>;
	var bgs:FlxTypedGroup<FlxSprite>;
	var bg2s:FlxTypedGroup<FlxSprite>;
	var discs:FlxTypedGroup<FlxSprite>;
    public static var canChar:Bool = false;
    public static var audioPlaying:Bool = false;
    public static var loadingsong:Bool = false;
    public static var isInstance:Bool = false;
    public static var canInput:Bool = true;

    //var tooLong:Float = (name.length > 18) ? 0.8 : 1; //Fucking Winter Horrorland might add later, grab from reset

    var playbutton:STButton;
    var forwardbutton:STButton;
    var rewindbutton:STButton;
    var charbutton:STButton;
    var micbutton:STButton;
	var scrollDots:FlxBackdrop;

    var awardTimer:FlxTimer = null;
    override function create()
        {
            canInput = true;
            Paths.clearStoredMemory();
            Paths.clearUnusedMemory();
            songOrder = CoolUtil.coolTextFile(Paths.txt('songOrder'));
            songs = getSongsInDirectory();
            FlxG.autoPause = false;
            isInstance = true;
            audioPlaying = false;
            //
            FlxG.sound.music.looped = false;
            if (vocals != null)
            vocals.looped = false;
            //

            CoolUtil.precacheSound('st_change');
            CoolUtil.precacheSound('st_no');


            bgs = new FlxTypedGroup<FlxSprite>();
            add(bgs);
            bg2s = new FlxTypedGroup<FlxSprite>();
            add(bg2s);
            discs = new FlxTypedGroup<FlxSprite>();
            add(discs);
            loadImages(bgs,'bg');
            loadImages(bg2s,'bg2');
            loadImages(discs,'disc');

            makeFreeplayTextShit();

            var overlay:FlxSprite = new FlxSprite().loadGraphic(Paths.image('soundtest/overlay'));
            overlay.antialiasing = ClientPrefs.globalAntialiasing;
            overlay.setGraphicSize(1280,720);
            overlay.updateHitbox();
            add(overlay);
            
            // buttons woooo
            
         /*   charbutton = new STButton(0,0,'charBf',[650,0,860,160],function(){
                if (firstonee)
                    {
                        if (!micbutton.toggled && audioPlaying)
                            {
                                FlxG.sound.play(Paths.sound('st_change'));
                                if (charbutton.toggled)
                                    {
                                        vocals.volume = 0;
                                        FlxG.sound.music.volume = 0;
                                    }
                                else
                                    {
                                        vocals.volume = 0.7;
                                        FlxG.sound.music.volume = 0.7;
                                    }
                            }
                    }
            }, 'canChar',
            function(){
                FlxG.sound.play(Paths.sound('st_no'));
            }); */
            add(charbutton);

            playbutton = new STButton(0,0,'pause','play',[970,610,1080,720],function(){
                if (firstonee)
                    {
                        if (playbutton.toggled && audioPlaying)
                            {
                                audioPlaying = false;
                                vocals.pause();
                                FlxG.sound.music.pause();
                            }
                        else
                            {
                                audioPlaying = true;
                                vocals.play();
                            }
                    }
			});
            add(playbutton);
            forwardbutton = new STButton(0,0,'foward','foward',[1140,610,1250,720],function(){
                {
                    changeItem(1,false,curSelectedPlaying+1);
                    playSong();
                }
			});
            add(forwardbutton);
            rewindbutton = new STButton(0,0,'rewind','rewind',[790,610,900,720],function(){
                {
                    changeItem(-1,false,curSelectedPlaying-1);
                    playSong();
                }
			});
            add(rewindbutton);
            micbutton = new STButton(0,0,'micena','mic',[640,610,740,720],function(){
                if (firstonee)
                    {
                        if (micbutton.toggled)
                            {
                                vocals.volume = 0;
                            }
                        else
                            {
                                if (charbutton.toggled)
                                    {
                                        vocals.volume = 0;
                                    }
                                else
                                    {
                                        vocals.volume = 0.7;
                                    }
                            }
                    }
			});
            add(micbutton);

            scrollDots = new FlxBackdrop(Paths.image('soundtest/dots2'), 60, 0, true, false);
            add(scrollDots);

            var titleSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image('soundtest/title'));
            titleSpr.antialiasing = ClientPrefs.globalAntialiasing;
            titleSpr.setGraphicSize(1280,720);
            titleSpr.updateHitbox();
            add(titleSpr);
            new FlxTimer().start(1.5, function(tmr:FlxTimer)
                {
                    fadeInText();
                });

            changeItem(0,false);

            // Mouse Cursor
            FlxG.mouse.enabled = true;
            FlxG.mouse.visible = true;
            var smashCursor:FlxSprite = new FlxSprite();
			smashCursor.loadGraphic(Paths.image('cursor'));
			smashCursor.antialiasing = ClientPrefs.globalAntialiasing;
			FlxG.mouse.load(smashCursor.pixels, 0.25, -5, -5);
            
            super.create();
        }

        var pausable:Bool = false;
        var firstonee:Bool = false;
        var stPlay:Bool = false;
    override function update(elapsed:Float)
        {
            if (!FlxG.sound.music.playing && audioPlaying)
                {
                    curSelected = curSelectedPlaying;
                    changeItem(1,false);
                    playSong();
                }
            if (audioPlaying)
                scrollDots.x += 0.50;
            else
                scrollDots.x -= 0.50;
            if (songPlaying)
                {
                    discs.forEach(function(spr:FlxSprite) {
                        if (audioPlaying)
                        spr.angle += 0.5;
                    });
                }
			if((controls.UI_UP_P) && canInput)
                changeItem(-1,true);
			else if ((controls.UI_DOWN_P) && canInput)
                changeItem(1,true);

            if (FlxG.mouse.wheel > 0)
                changeItem(-1,true,null,true);
			if (FlxG.mouse.wheel < 0)
                changeItem(1,true,null,true);

            if (FlxG.keys.justPressed.ENTER && canInput)
                {
                    playSong();
                }

            if (FlxG.keys.justPressed.SPACE && canInput && firstonee)
                {
                    playbutton.btnFunc = true;
                    if (playbutton.toggled)
                        {
                            playbutton.toggled = false;
                            audioPlaying = true;
                            vocals.play();
                        }
                    else
                        {
                            playbutton.toggled = true;
                            audioPlaying = false;
                            vocals.pause();
                        }
                }
            if (controls.UI_RIGHT_P && canInput && !loadingsong)
                forwardbutton.triggerFunction = true;

            if (controls.UI_LEFT_P && canInput && !loadingsong)
                rewindbutton.triggerFunction = true;

            if (FlxG.keys.justPressed.SHIFT && canInput && firstonee)
                {
                    if (validate('canChar'))
                        {
                            FlxG.sound.play(Paths.sound('st_no'));
                        }
                    else if (!micbutton.toggled)
                        {
                            FlxG.sound.play(Paths.sound('st_change'));
                            charbutton.btnFunc = true;   
                            if (charbutton.toggled)
                                {
                                    charbutton.toggled = false;
                                    vocals.volume = 0.7;
                                    FlxG.sound.music.volume = 0.7;
                                }
                            else
                                {
                                    charbutton.toggled = true;
                                    vocals.volume = 0;
                                    FlxG.sound.music.volume = 0;
                                }
                        }
                    else
                        {
                            charbutton.btnFunc = true;   
                        }
                }

            if (FlxG.keys.justPressed.M && canInput && firstonee)
                {
                    micbutton.btnFunc = true;
                    if (micbutton.toggled)
                        {
                            micbutton.toggled = false;
                            if (charbutton.toggled)
                                {
                                    vocals.volume = 0;
                                }
                            else
                                {
                                    vocals.volume = 0.7;
                                }
                        }
                    else
                        {
                            micbutton.toggled = true;
                            vocals.volume = 0;
                        }
                }

            if (FlxG.mouse.justPressed && canInput)
                {
                    for (item in grpSongs.members)
                    {
                        if (FlxG.mouse.overlaps(item) && item.targetY == 0)
                            playSong();
                    }
                }

			if (controls.BACK && canInput)
			{
                canInput = false;
                FlxG.mouse.enabled = false;
                FlxG.mouse.visible = false;
                isInstance = false;
                destroyFreeplayVocals();
				FlxG.sound.play(Paths.sound('cancelMenu'));
                FlxTransitionableState.skipNextTransIn = true;
                FlxTransitionableState.skipNextTransOut = true;
			}

            super.update(elapsed);
        }

        function validate(cv:String)
            {
                var isReal:Bool = false;
                switch (cv)
                {
                    case 'canChar':
                        isReal = !SoundTest.canChar;
                }
                return isReal;
            }
        
	var instPlaying:Int = -1;
	private static var vocals:FlxSound = null;
    public static var noBfVocals:Bool = false;
    var orgCharToggle:Bool = false;
    function playSong()
        {
            canInput = false;
            firstonee = true;
            curSelectedPlaying = curSelected;
            pausable = false;
            loadingsong = true;
            audioPlaying = true;
            orgCharToggle = charbutton.toggled;
            charbutton.toggled = false;
            micbutton.toggled = false;
            micbutton.loadGraphic(Paths.image('soundtest/${micbutton.posprite}'));
			if(instPlaying != curSelected)
			{
				#if PRELOAD_ALL
				destroyFreeplayVocals();
SoundTest.destroyFreeplayVocals();
				FlxG.sound.music.volume = 0;
				vocals = new FlxSound().loadEmbedded(Paths.voices(curSong));

                if (curSong == 'LMHY') // i had to hardcode it???
                    {
                        hasBf.set('LMHY',false);
                        hasVoltz.set('LMHY',true);
                        defDir.set('LMHY',true);
                    }


                playbutton.loadGraphic(Paths.image('soundtest/${playbutton.posprite}'));
                playbutton.toggled = false;

				FlxG.sound.list.add(vocals);
				vocals.persist = true;
				vocals.looped = true;
				vocals.volume = 0.7;
				instPlaying = curSelected;
				FlxG.sound.playMusic(Paths.inst(curSong), 0.7, false);
				vocals.play();
                songPlaying = true;

                if (showVoiceUI.get(curSong) == true)
                    {
                        charbutton.visible = false;
                        micbutton.visible = false;
                    }
                else
                    {
                        charbutton.visible = true;
                        micbutton.visible = true;
                    }

                if (canChar && orgCharToggle)
                    {
                        FlxG.sound.music.volume = 0;
                        vocals.volume = 0;
                        charbutton.loadGraphic(Paths.image('soundtest/${charbutton.poaltsprite}'));
                        charbutton.toggled = true;
                    }

                new FlxTimer().start(0.4, function(tmr:FlxTimer)
                    {
                        pausable = true;
                    });
				#end
			}
            loadingsong = false;
            canInput = true;
        }
        public static function destroyFreeplayVocals() {
            if(vocals != null) {
                vocals.stop();
                vocals.destroy();
            }
            vocals = null;
        }

        var lastStepHit:Int = -1;
    override function stepHit()
        {
		    //if (FlxG.sound.music.time > Conductor.songPosition + 20 || FlxG.sound.music.time < Conductor.songPosition - 20)
            //    {
            //       resyncVocals();
            //    }
		    if(curStep == lastStepHit) {
		    	return;
		    }

		    lastStepHit = curStep;
		    super.stepHit();
        }
        function resyncVocals():Void
        {
            vocals.pause();
    
            FlxG.sound.music.play();
            Conductor.songPosition = FlxG.sound.music.time;
            vocals.time = Conductor.songPosition;
            vocals.play();
        }
        var alphaAble:Bool = false;
        function fadeInText()
            {
                alphaAble = true;
                var timeShit:Float = 0.4;
                for (item in grpSongs.members)
                {
                    FlxTween.tween(item, {alpha: 0.6}, timeShit, {
                        ease: FlxEase.expoInOut
                    });
        
                    if (item.targetY == 0)
                    {
                        FlxTween.tween(item, {alpha: 1}, timeShit, {
                            ease: FlxEase.expoInOut
                        });
                    }
                }
            }

    var madbearFucksEggs:Bool = true; // a little delay thing
    function changeItem(change:Int = 0, playSound:Bool = true, ?forceNum:Int = null, ?skipAnywayCauseDanSaidSo:Bool = false)
    {
        if (madbearFucksEggs || skipAnywayCauseDanSaidSo)
            {
                madbearFucksEggs = false;
                if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
        
                curSelected += change;
        
                if (forceNum != null)
                    curSelected = forceNum;
            
                if (curSelected < 0)
                    curSelected = songs.length - 1;
                if (curSelected >= songs.length)
                    curSelected = 0;
        
                var bullShit:Int = 0;
        
                for (item in grpSongs.members)
                {
                    item.targetY = bullShit - curSelected;
                    bullShit++;
        
                    if (alphaAble)
                    item.alpha = 0.6;
                    // item.setGraphicSize(Std.int(item.width * 0.8));
        
                    if (item.targetY == 0)
                    {
                        if (alphaAble)
                        item.alpha = 1;
                        var sprid = grabIntFromArray(enems,char.get(item.text));
                        curSong = item.text;
        
                        bgs.forEach(function(spr:FlxSprite) {
                            if (spr.ID == sprid)
                                {
                                    FlxTween.tween(spr, {alpha: 1}, 0.2, {
                                        ease: FlxEase.expoInOut
                                    });
                                }
                            else
                                {
                                    FlxTween.tween(spr, {alpha: 0}, 0.2, {
                                        ease: FlxEase.expoInOut
                                    });
                                }
                        });
                        bg2s.forEach(function(spr:FlxSprite) {
                            if (spr.ID == sprid)
                                {
                                    FlxTween.tween(spr, {alpha: 1}, 0.2, {
                                        ease: FlxEase.expoInOut
                                    });
                                }
                            else
                                {
                                    FlxTween.tween(spr, {alpha: 0}, 0.2, {
                                        ease: FlxEase.expoInOut
                                    });
                                }
                        });
                        discs.forEach(function(spr:FlxSprite) {
                            if (spr.ID == sprid)
                                {
                                    FlxTween.tween(spr, {alpha: 1}, 0.2, {
                                        ease: FlxEase.expoInOut,
                                        onComplete: function(twn:FlxTween)
                                            {
                                                new FlxTimer().start(0.05, function(tmr:FlxTimer)
                                                    {
                                                        madbearFucksEggs = true;
                                                    });
                                            }
                                        }); 
                                }
                            else
                                {
                                    FlxTween.tween(spr, {alpha: 0}, 0.2, {
                                        ease: FlxEase.expoInOut
                                    });
                                }
                        });
                    }
                }
            }
    }

    function makeFreeplayTextShit()
        {
            grpSongs = new FlxTypedGroup<Alphabet>();
            add(grpSongs);
		    for (i in 0...songs.length)
		    {
		    	var songText:Alphabet = new Alphabet(-10, (70 * i) + 30, songs[i], true, false);
		    	songText.isMenuItem = true;
                songText.alpha = 0;
                //songText.startImm = true;
                songText.xAdd = -960;
		    	songText.targetY = i;
                songText.scale.set(0.8,0.8);
		    	grpSongs.add(songText);
		    }
        }

	function loadImages(grp:FlxTypedGroup<FlxSprite>, name:String) {
		for (i in 0...enems.length) {
            var spr:FlxSprite = new FlxSprite();
			spr.loadGraphic(Paths.image('soundtest/${enems[i]}/${name}'));
			spr.antialiasing = ClientPrefs.globalAntialiasing;
			if (i != 0)
				spr.alpha = 0;
            if (name != 'disc')
            spr.setGraphicSize(1280,720);
            else
            spr.setGraphicSize(Std.int(spr.width * 0.8));
            spr.updateHitbox();
			grp.add(spr);
			spr.ID = i;
		}
	}

    function getSongsInDirectory()
        {
           var songListGet:Array<String> = [];
            #if MODS_ALLOWED
            var directories:Array<String> = [/*Paths.mods('songs/'),*/ Paths.mods(Paths.currentModDirectory + '/songs/'), Paths.getPreloadPath('songs/')];
            for (i in 0...directories.length) {
                var directory:String = directories[i];
                if(FileSystem.exists(directory)) {
                    for (file in FileSystem.readDirectory(directory)) {
                        var path = haxe.io.Path.join([directory, file]);
                        if (doSkipFile(file))
                            {
                                //FlxG.sound.playMusic(Paths.inst(file), 0); // preloads????
                                //FlxG.sound.playMusic(Paths.voices(file), 0); half preload B)
                                if (!file.endsWith('-V'))
                                    {
        
                                        songListGet.push(file);
                                    }

                                char.set(file, determineChar(file));
                                //if (sys.FileSystem.isDirectory(path)) {
                                //    var fileCheck:String = file.substr(0, file.length - 5);
                                 //   if(!songLoaded.exists(fileCheck)) {
                                  //      songLoaded.set(fileCheck, true);
                                  //  }
                                //}
                            }
                    }
                }
            }
            #else
            songListGet = ['test'];
            #end

            var reorganizedVers:Array<String> = [];
            for (i in 0...songOrder.length) // reorganizing by song tool :)
                {
                    for (z in 0...songListGet.length)
                        {
                            hasBf.set(songOrder[i].toLowerCase().split(':')[0], verifyChar(songOrder[i].split(':')[1]));
                            hasVoltz.set(songOrder[i].toLowerCase().split(':')[0], verifyChar(songOrder[i].split(':')[2]));
                            defDir.set(songOrder[i].toLowerCase().split(':')[0], verifyChar(songOrder[i].split(':')[3]));
                            showVoiceUI.set(songOrder[i].toLowerCase().split(':')[0], verifyChar(songOrder[i].split(':')[4]));
                            if (songOrder[i].toLowerCase().split(':')[0] == songListGet[z].toLowerCase())
                                reorganizedVers.push(songListGet[z]);
                        }
                }
                songListGet = reorganizedVers;

            return songListGet;
        }
    function verifyChar(leTo:String)
        {
            var iop:Bool = false;
            if (leTo == 't')
                iop = true;
            return iop;
        }

    function doSkipFile(fileName:String)
        {
            var canskip:Bool = true;

            for (i in skipPaths)
                {
                    if (fileName == i.toLowerCase())
                        canskip = false;
                }

            return canskip;
        }

    function checkforchar(song:String,chara:String)
        {
            var hasChar:Bool = false;

            if (charmap.get(song) == chara)
                hasChar = true;

            return hasChar;
        }
    function grabIntFromArray(theArray:Array<String>,leString:String)
        {
            var bruh:Int = 0;
            for (i in 0...theArray.length)
                {
                    if (theArray[i] == leString)
                        bruh = i;
                }
            return bruh;
        }

    function determineChar(song:String)
        {
            var leChar:String;
            
            leChar = charmap.get(song);

            if (leChar == null)
                leChar = 'gf';

            return leChar;
        }
  //  }
        private var charmap:Map<String, String> = 
        [
            'tutorial' => 'gf',
        ];
    
}