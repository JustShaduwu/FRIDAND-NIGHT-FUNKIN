package;

import flixel.FlxSprite;
import flixel.util.FlxGradient;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.input.keyboard.FlxKey;
import lime.utils.Assets;
import sys.io.File;
import sys.FileSystem;

typedef JukeboxSong = {
    var name:String;
    var ?song:String;
    var cover:String;
    var bpm:Float;
}

class PortalTunesLALState extends MusicBeatState
{
   	var bg:FlxSprite;
    var overlay:FlxSprite;
    var songText:FlxText;
    var lengthText:FlxText;
    var songs:Array<JukeboxSong> = [
        {name:"Portal", cover:"fridand", bpm:180},
        {name:'Alone', cover:'engine', bpm:150},
        {name:'Shadow', cover:'engine', bpm:240},
        {name:'Waves', cover:'engine', bpm:110},
        {name:'Hikaru', cover:'engine', bpm:160},
        {name:'Chan', cover:'engine', bpm:120},
        {name:'Portalgedon', cover:'engine', bpm:180}
    ];
    var curSelected:Int = 0;
    private var screen:FlxCamera;
	private var cam:FlxCamera;
    var cover:FlxSprite = new FlxSprite(0, 155);

    override function create()
    {

        screen = new FlxCamera();
		cam = new FlxCamera();
		cam.bgColor.alpha = 0;
		FlxG.cameras.reset(screen);
		FlxG.cameras.add(cam);
		FlxCamera.defaultCameras = [cam];

        persistentUpdate = true;

        super.create();

		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.scrollFactor.set(0, 0);
		bg.updateHitbox();
		bg.screenCenter();
		// add(bg);
        bg.cameras = [screen];

        cover.loadGraphic(Paths.image('troll'));
        cover.screenCenter(X);
        cover.antialiasing = true;
        cover.cameras = [screen];
        add(cover);

        songText = new FlxText(0, Std.int(FlxG.height * 0.65), songs[0].name);
		songText.screenCenter(X);
        songText.cameras = [screen];
        add(songText);

        lengthText = new FlxText(0, Std.int(FlxG.height * 0.72), '');
        lengthText.cameras = [screen];
		lengthText.screenCenter(X);
        add(lengthText);

        var playText:FlxText = new FlxText(0, Std.int(FlxG.height * 0.82), 'Press SPACE to play');
        playText.cameras = [screen];
		playText.screenCenter(X);
        add(playText);

        var leaveText:FlxText = new FlxText(0, Std.int(FlxG.height * 0.88), 'Press ESC to leave');
        leaveText.cameras = [screen];
		leaveText.screenCenter(X);
        add(leaveText);

        songText.cameras = [screen];

        overlay = new FlxSprite(0,0).loadGraphic(Paths.image('LMAO'));
        overlay.antialiasing = true;
        add(overlay);
        changeSong();
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        screen.zoom = FlxMath.lerp(0.9, screen.zoom, 0.95);

        if(controls.UI_LEFT_P || controls.UI_RIGHT_P)
            changeSong(controls.UI_LEFT_P ? -1 : 1);

        if(controls.BACK)
            FlxG.switchState(new PortalTunesState());

        if(FlxG.sound.music != null)
        {
            Conductor.songPosition = FlxG.sound.music.time;
            if(controls.ACCEPT)
            {
                if(!FlxG.sound.music.playing)
                {
                    FlxG.sound.music.play();
                }
                else
                {
                    FlxG.sound.music.pause();
                 //  songText.changeColor(FlxColor.WHITE);
                }
            }
        }
    }

    static var loadedSongs:Array<String> = [];
    function changeSong(change:Int = 0)
    {
        if(FlxG.sound.music != null)
            FlxG.sound.music.stop();

        curSelected += change;
        if(curSelected >= songs.length)
            curSelected = 0;
        else if(curSelected < 0)
            curSelected = songs.length - 1;

        cover.loadGraphic(Paths.image('tunes/${songs[curSelected].cover}', 'preload'));
        cover.screenCenter(X);

        songText.text = '< ${songs[curSelected].name} >';
        Conductor.changeBPM(songs[curSelected].bpm);
       
        var songName:String = songs[curSelected].song == null ? songs[curSelected].name.toLowerCase() : songs[curSelected].song;
        trace('NEXT SONG: $songName');

        if(!loadedSongs.contains(songName))
        {
            loadedSongs.push(songName);
            #if sys
            sys.thread.Thread.create(() -> {
                FlxG.sound.playMusic(Paths.inst(songName), 0.75);
                FlxG.sound.music.pause();
                lengthText.text = 'Length : ${Std.int(FlxG.sound.music.length / 1000 / 60)}:${Std.int(FlxG.sound.music.length / 1000) % 60}';
            });
            #else
            FlxG.sound.playMusic(Paths.inst(songName), 0.75);
            FlxG.sound.music.pause();
            lengthText.text = 'Length : ${Std.int(FlxG.sound.music.length / 1000 / 60)}:${Std.int(FlxG.sound.music.length / 1000) % 60}';
            #end
        }
        else
        {
            FlxG.sound.playMusic(Paths.inst(songName), 0.75);
            FlxG.sound.music.pause();
            lengthText.text = 'Length : ${Std.int(FlxG.sound.music.length / 1000 / 60)}:${Std.int(FlxG.sound.music.length / 1000) % 60}';
        }
    }

    override function beatHit()
    {
        screen.zoom += 0.015;
    }
}