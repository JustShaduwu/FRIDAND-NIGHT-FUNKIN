package;


import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.system.FlxSound;
import lime.app.Application;
import flixel.ui.FlxBar;
import haxe.Json;
import flixel.util.FlxCollision;
#if windows
import Discord.DiscordClient;
#end
import openfl.display.BitmapData;
import openfl.utils.Assets;
import haxe.Exception; //funi
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
#if cpp
import sys.FileSystem;
import sys.io.File;
import sys.thread.Thread;
#end
import flixel.FlxState;
import flixel.addons.ui.FlxUIState;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;
import flixel.addons.transition.FlxTransitionableState;

enum PreloadType {
    atlas;
    image;
    imagealt;
    music;
}

/**
 * Preloading class which loads everything including music (exepting sounds)
 */
class Preloading extends MusicBeatState {

    var globalRescale:Float = 2/3;
    var preloadStart:Bool = false;

    var loadText:FlxText;
    var loadBar:FlxBar;

    public var isMenu:Bool = false;

    var assetStack:Map<String, PreloadType> = [

        // Images from shared folder
        'funi' => PreloadType.image, 
	    'unlocks' => PreloadType.image, 

        //Preload UI stuff
        'healthBar' => PreloadType.image,
		'introicons/and-og' => PreloadType.imagealt,
		'introicons/and-og-extend' => PreloadType.imagealt,		
		'introicons/and-ogno' => PreloadType.imagealt,
		'introicons/gf' => PreloadType.imagealt,
	    'introicons/gf-extend' => PreloadType.imagealt,
		'introicons/shadow-and-og' => PreloadType.imagealt,
		'introicons/shadow-and-og-extend' => PreloadType.imagealt,

        //Note Skins and Splashes
        'NOTE_assets' => PreloadType.image,
        'HURTNOTE_assets' => PreloadType.image,
        'HURTnoteSplashes_assets' => PreloadType.image,

        //Icons cause why not?
        'icons/icon-face' => PreloadType.imagealt,

        //Preload countdown assets for better loading time
        'go' => PreloadType.image, 
        'ready' => PreloadType.image, 
        'set' => PreloadType.image,  

        //Preload the entire character roster (Sorry, this doesn't mean no more lag spikes when hardcoded, but it does work if the character change events are in the chart editor)
        'BOYFRIEND' => PreloadType.atlas,
	    'And-Og' => PreloadType.atlas,
		'M-And-Og' => PreloadType.atlas,
		'Shadow-And-Body-Og' => PreloadType.atlas,

        //Menu stuff (atlas: XML files, imagealt: images from the preload folder)
        'logoBumpin' => PreloadType.atlas,
        'menuBG' => PreloadType.imagealt,
        'menuBGMagenta' => PreloadType.imagealt,
        'menuDesat' => PreloadType.imagealt,
        'menuBGBlue' => PreloadType.imagealt,

        //songs
		'shadow' => PreloadType.music,
        'alone' => PreloadType.music,
        'portal' => PreloadType.music,
		'habits' => PreloadType.music,

    ];
    var maxCount:Int;

    public static var preloadedAssets:Map<String, FlxGraphic>;
    //var backgroundGroup:FlxTypedGroup<FlxSprite>;
    var bg:FlxSprite;

    public var newClass:Any;

    // Made this in case you make some logics of loading state when switching menus like MusicBeatState.switchState(new Preloading(true, new FreeplayState()));
    public function new(?e:Bool = false, ?switchClass:FlxState)
        {
            this.isMenu = e;
            this.newClass = switchClass;

            super();
        }

    override public function create() {
        super.create();

        FlxG.drawFramerate = 60;
        FlxG.updateFramerate = 60;

        FlxTransitionableState.skipNextTransIn = true;
        FlxTransitionableState.skipNextTransOut = true;

        FlxG.camera.alpha = 0;

        maxCount = Lambda.count(assetStack);
        trace(maxCount);
        // create funny assets
       // backgroundGroup = new FlxTypedGroup<FlxSprite>();
        FlxG.mouse.visible = true;

        preloadedAssets = new Map<String, FlxGraphic>();

        var leRandom:Int = 2;

        // uncomment this if you want random loading screens
        /**
        bg = new FlxSprite().loadGraphic(Paths.image('loadingScreens/loadingscreen-${FlxG.random.int(1, leRandom)}'));
        bg.screenCenter();
        bg.alpha = 0;
        add(bg);
         */

        //and comment this if you want the funi random loading screen
        bg = new FlxSprite().loadGraphic(Paths.image('funkay'));
		bg.screenCenter();
        bg.alpha = 0;
		add(bg);

        FlxTween.tween(bg, {alpha: 1}, 1);

        // uncomment this for random loading screens
        //refreshLoadScreen();
    
        FlxTween.tween(FlxG.camera, {alpha: 1}, 0.5, {
            onComplete: function(tween:FlxTween){
                Thread.create(function(){
                    assetGenerate();
                });
            }
        });

        // save bullshit
        FlxG.save.bind('funkin', 'ninjamuffin99');

        loadText = new FlxText(-100, FlxG.height - (32 + 7), 0, 'Loading...', 32);
        loadText.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(loadText);
        loadText.alpha = 0;

        loadBar = new FlxBar(0, 730, LEFT_TO_RIGHT, 1280, 20, this,
        'storedPercentage', 0, 1);
        loadBar.alpha = 0;
        loadBar.createFilledBar(0xFF2E2E2E, FlxColor.WHITE);
        add(loadBar);

        FlxTween.tween(loadText, {alpha: 1, x: 5}, 0.5, {startDelay: 0.5});
        FlxTween.tween(loadBar, {alpha: 1, y: 700}, 0.5, {startDelay: 0.5});
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
    }

    var isRefreshing:Bool = false;

    function refreshLoadScreen() {
        isRefreshing = true;
        FlxTween.tween(bg, {alpha: 1}, 1.5, {startDelay: 2, onComplete: function(twn:FlxTween)
        {
            remove(bg);
            add(bg);
            FlxTween.tween(bg, {alpha: 1}, 1.5);
            bg.loadGraphic(Paths.image('loadingscreens/vsandshadows'));
            isRefreshing = false;
        },
        type: LOOPING});

    }

    var storedPercentage:Float = 0;

    function assetGenerate() {
        //
        var countUp:Int = 0;
        for (i in assetStack.keys()) {
            trace('calling asset $i');

            FlxGraphic.defaultPersist = true;
            switch(assetStack[i]) {
                case PreloadType.imagealt:
                    var menuShit:FlxGraphic = FlxG.bitmap.add(Paths.image(i));
                    preloadedAssets.set(i, menuShit);
                    trace('menu asset is loaded');
                case PreloadType.image:
                    var savedGraphic:FlxGraphic = FlxG.bitmap.add(Paths.image(i, 'shared'));
                    preloadedAssets.set(i, savedGraphic);
                    trace(savedGraphic + ', yeah its working');
                case PreloadType.atlas:
                    var preloadedCharacter:Character = new Character(FlxG.width / 2, FlxG.height / 2, i);
                    preloadedCharacter.visible = false;
                    add(preloadedCharacter);
                    trace('character loaded ${preloadedCharacter.frames}');
                case PreloadType.music:
                    var savedInst:FlxGraphic = FlxG.bitmap.add(Paths.inst(i));
                    var savedVocals:FlxGraphic = FlxG.bitmap.add(Paths.voices(i));
                    preloadedAssets.set(i, savedInst);
                    preloadedAssets.set(i, savedVocals);
                    trace('loaded vocals of $savedVocals');
                    trace('loaded instrumental of $savedInst');
            }
            FlxGraphic.defaultPersist = false;
        
            countUp++;
            storedPercentage = countUp/maxCount;
            if(countUp == maxCount)
            {
                loadText.text = (isMenu ? 'Game Fully Loaded! Swiching To Next State...' : 'Game Fully Loaded! Launching Title Sequence...');
            }
        }

        ///*
        FlxTween.tween(FlxG.camera, {alpha: 0}, 0.5, {startDelay: 1,
            onComplete: function(tween:FlxTween){
                    if(!isMenu)
                    MusicBeatState.switchState(new TitleState());
                    else
                    MusicBeatState.switchState(newClass);
            }});
            }
        }