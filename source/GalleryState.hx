package; // supongo que no estas en una carpeta

class GalleryState extends MusicBeatState //flixel.FlxState
{
// alo xd
    var theImgs:Array<String> = ["assets/images/creditslayer/shaduwuvoice.png","assets/images/creditslayer/berevoice.png","assets/images/creditslayer/sharonvoice.png"];
    var curImage:Int = 0;
    var Imagenlal:flixel.FlxSprite = new flixel.FlxSprite();
    function changeImage(?diu:Int) {
    curImage += diu;

    if (curImage >= theImgs.length)
    curImage = 0;
    if (curImage <= -1)
    curImage = theImgs.length - 1;
    // si todo sale bien deberÃ­a aparecer
    Imagenlal.loadGraphic(theImgs[curImage]);
    Imagenlal.screenCenter();

    }
    override function create(){super.create();
    //por ahora solo es la imagen jijiji 
    add(Imagenlal);
    }
    override function update(elapsed:Float) {
    super.update(elapsed);
    // revisar si se presiona izquierda o derecha y cambiar la imagen
    
    if (flixel.FlxG.keys.anyJustPressed([DOWN, UP]))
        changeImage(flixel.FlxG.keys.anyJustPressed([UP]) ? -1 : 1);
    }

}