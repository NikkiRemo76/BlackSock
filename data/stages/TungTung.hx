import funkin.backend.utils.NdllUtil;
import sys.FileSystem;
import funkin.backend.utils.WindowUtils;
import flixel.math.FlxRandom;
import flixel.util.FlxCollision;
var rnd:FlxRandom = new FlxRandom();

bg = new FlxSprite();
bg.makeGraphic(1280 * 3, 720 * 3, FlxColor.WHITE);
bg.updateHitbox();
bg.screenCenter();
//bg.zoomFactor = 0;
bg.scrollFactor.set(0,0);
add(bg);
static var oldWallpaper;
static var setWallpaper = NdllUtil.getFunction("freaky", "change_wallpaper", 1);
static var getWallpaper = NdllUtil.getFunction('freaky', 'get_wallpaper', 0);
static var path = StringTools.replace(FileSystem.absolutePath(Assets.getPath("assets/images/stages/sahur/hell.png")), "/", "\\");
var wave = new CustomShader("wave");
function postCreate() {
    oldWallpaper = getWallpaper();

    WindowUtils.onClosing = () -> {
        setWallpaper(path);
    }
    strumLines.members[1].characters[1].alpha = 0;
    strumLines.members[1].characters[0].alpha = 1;
    //strumLines.members[1].characters[1].x -= 400;
    //strumLines.members[1].characters[1].y += 100;

    //camGame.addShader(wave);
    camHUD.addShader(wave);
    wave.frequency = 0;
    wave.amplitude = 0;
    goblin.animation.addByPrefix('ni', 'KRICHITSUCHKA0', 24, true);
    goblin.animation.play('ni');
    goblin.animation.addByPrefix('walk', 'walk0', 24, true);
}
function onGameOver(event:GameOverEvent) {
//    setWallpaper(path);
}
function destroy() {
//    setWallpaper(oldWallpaper);
}
function slenderRUN() {
    trace("slender");
    FlxTween.tween(slender, {x: -2000}, 1,{onComplete: function(f:FlxTween){slender.x = 2200;}});
}
var trainCooldown:Int = 0;
var trainMoving:Bool = false;
var trainSound:FlxSound;
trainSound = FlxG.sound.load(Paths.sound("train_passes"));
function beatHit(curBeat:Int) {
    if (!trainMoving)
		trainCooldown += 1;

	if (curBeat % 8 == 4 && FlxG.random.bool(30) && !trainMoving && trainCooldown > 8 && !trainSound.playing)
	{
		trainCooldown = FlxG.random.int(-4, 0);
		slenderRUN();
	}
}
var itsTimeToRun = false;
function tung(tungtung) {
    if(tungtung == '1'){
        strumLines.members[1].characters[1].alpha = 1;
        strumLines.members[1].characters[0].alpha = 0;
        itsTimeToRun = true;
        goblin.animation.play('walk');
    }
    if(tungtung == '2'){
        tungSpeed = 0;
        anims = true;
        tungPos = bfPos + 100;
    }
    
}
var anims = false;
var tungSpeed = 2;
var bfPos = 850;
var tungPos = bfPos + 100;
var localTime:Float = 0;
function update(elapsed:Float) {
    localTime += elapsed;
    wave.iTime = localTime;
    wave.frequency += 0.001;
    wave.amplitude += 0.00001;
    if(itsTimeToRun){
        camHUD.alpha = 0;
        strumLines.members[1].characters[1].x = FlxMath.lerp(strumLines.members[1].characters[1].x, bfPos, (1/30)*240*elapsed);
        strumLines.members[1].characters[0].x = FlxMath.lerp(strumLines.members[1].characters[0].x, bfPos, (1/30)*240*elapsed);
        //trace(strumLines.members[1].characters[1].x);
        goblin.x += 2;
        if(strumLines.members[1].characters[1].x <= 20000){
            if(controls.LEFT){
                bfPos -= rnd.float(1, 5);
                strumLines.members[1].characters[1].animation.play('singRIGHT');
            }
            if(controls.RIGHT){
                bfPos += rnd.float(1, 5);
                strumLines.members[1].characters[1].animation.play('singLEFT');
            }
        }
        if(controls.LEFT_P){
            
            strumLines.members[1].characters[1].flipX = true;
        }
        if(controls.RIGHT_P){
            
            strumLines.members[1].characters[1].flipX = false;
        }

        if(controls.RIGHT && controls.LEFT){
            strumLines.members[1].characters[1].animation.play('idle');
        }

        strumLines.members[0].characters[0].x += tungSpeed;

        if(anims){
            strumLines.members[0].characters[0].x = FlxMath.lerp(strumLines.members[0].characters[0].x, tungPos, (1/30)*240*elapsed);
        }

        
    }
    //if (FlxCollision.pixelPerfectCheck(strumLines.members[0].characters[0], strumLines.members[1].characters[1], onCollision))
    //{
    //    trace("Пиксель-перфект столкновение!");
    //}
    //if (checkSimpleCollision(strumLines.members[0].characters[0], strumLines.members[1].characters[1]))
    //{
    //    trace("Simple");
    //}
    
    // Более точная проверка (аналог pixel-perfect)
    if (checkPreciseCollision(strumLines.members[0].characters[0], strumLines.members[1].characters[1]))
    {
        if(anims){
            trace('DEAD2');
            camGame.alpha = 0;
        }
        else{
            trace('DEAD1');
            health = -1;
        }
    }
    //if (FlxG.overlap(strumLines.members[1].characters[1], strumLines.members[0].characters[0], onCollision))
    //{
    //    if(anims){
    //        trace('DEAD2');
    //        camGame.alpha = 0;
    //    }
    //    else{
    //        trace('DEAD1');
    //        health = -1;
    //    }
    //    
    //}
}
// Простая проверка пересечения прямоугольников
    function checkSimpleCollision(obj1:FlxSprite, obj2:FlxSprite):Bool
    {
        return obj1.x < obj2.x + obj2.width &&
               obj1.x + obj1.width > obj2.x &&
               obj1.y < obj2.y + obj2.height &&
               obj1.y + obj1.height > obj2.y;
    }
    
    // Более точная проверка (учитывает scale и offset)
    function checkPreciseCollision(obj1:FlxSprite, obj2:FlxSprite):Bool
    {
        var rect1:FlxRect = obj1.getRotatedBounds();
        var rect2:FlxRect = obj2.getRotatedBounds();
        
        return rect1.overlaps(rect2);
    }
function onCollision(obj1:FlxObject, obj2:FlxObject):Void
{
    trace("Столкновение detected!");
    trace('Объект 1: ${obj1.x}, ${obj1.y}');
    trace('Объект 2: ${obj2.x}, ${obj2.y}');
}
//case "singLEFT" | "singLEFT-alt":
//    bfPos -= rnd.float(1, 5);
//    boyfriend.flipX = false;
//case "singRIGHT" | "singRIGHT-alt":
//    bfPos += rnd.float(1, 5);
//    boyfriend.flipX = true;