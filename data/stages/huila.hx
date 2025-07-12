//importScript("data/scripts/resizing");
//ratioThing(1000, 1000, false);
//function destroy(){
//    ratioThing(1280, 720, true);
//}
import hxvlc.flixel.FlxVideoSprite;
import openfl.display.BlendMode;

import flixel.effects.particles.FlxEmitter.FlxTypedEmitter;
//import flixel.system.FlxPhysics;
introLength = 8;
var video = new FlxVideoSprite(-320, -180);

introSounds = ['intros/burger/thre', 'intros/burger/two', "intros/burger/one", "intros/burger/burger"];

//var aura = new CustomShader("Aura");

function onSongEnd() {
    FlxG.save.data.songFinished100 = true;
}
function zoom(camZoomValue:String)
{
    defaultCamZoom = Std.parseFloat(camZoomValue);
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
function slenderRUN() {
    trace("slender");
    FlxTween.tween(slender, {x: 1300}, 1,{onComplete: function(f:FlxTween){slender.x = -1700;}});
}
var tankSpeed:Float = FlxG.random.float(5, 7);
var tankAngle:Float = FlxG.random.int(-90, 45);
var localTime:Float = 0;
function update(elapsed:Float) {
    window.fullscreen = false;
    localTime += elapsed;
    jpeg.iTime = localTime;
    //aura.iTime += elapsed;
    //trace(video.bitmap.bitmapData);
    tankAngle += elapsed * tankSpeed;
	runn.angle = tankAngle - 90 + 15;
	runn.x = 700 + (1500 * Math.cos(Math.PI / 180 * (1 * tankAngle + 180)));
	runn.y = 1000 + (1100 * Math.sin(Math.PI / 180 * (1 * tankAngle + 180)));

    //player.velocity.y += gravity * elapsed;
}
var start = true;
jpeg = new CustomShader('jpeg');
function part1() {
    stat.visible = true;
    runn.visible = true;
    flor.visible = true;
    slender.visible = true;
    ded.visible = true;

    particles.scale.set(0.8, 0.8);
	particles.speed.set(250, 250);
	particles.launchAngle.set(-90, -90);
	particles.alpha.set(1, 1, 0, 0);
	particles.angle.set(-180, 30);
	particles.lifespan.set(4, 4);
    particles.blend = null;
	particles.start(false, 0.03);
}
function part2() {
    
    FlxTween.tween(ded, {y: -200}, 1, {ease: FlxEase.backOut});
    stat.shader = jpeg;
}
function end() {
    FlxTween.tween(camCut, {alpha: 0}, 20);
    FlxTween.tween(camHUD, {alpha: 1}, 20);
}
function cutsene() {
    FlxG.autoPause = false;
    canPause = false;
    FlxTween.tween(camGame, {alpha: 0}, 1);
    FlxTween.tween(camHUD, {alpha: 0}, 1);
    //camHUD.alpha = 0;
    camCut.alpha = 1;
    video.bitmap.time = 0;
    ratioThing(1920, 1080, false);
    video.load(Assets.getPath(Paths.video('кастсцена')), [':no-audio']);
    video.antialiasing = Options.antialiasing;
    //video.screenCenter();
    video.scale.set(0.7, 0.7);
    add(video);
    video.play();
    video.camera = camCut;
}
var camCut:FlxCamera = new FlxCamera();
var gravity:Float = 600; // Сила гравитации
var platforms:Array<FlxSprite> = [];
function onSongStart() {
    babka();
    //PlayState.resyncVocals();
    camGame.visible = true;
    //camGame.addShader(aura);
}
var babkaScreamersound:FlxSound;
babkaScreamersound = FlxG.sound.load(Paths.sound("scream"));
function babkaScreamer() {
    babkaScreamersound.play();
    trace('black');
    babka.alpha = 1;
    FlxTween.tween(babka, {alpha: 0}, 3);
}

function create() {
    stat.visible = false;
    runn.visible = false;
    flor.visible = false;
    slender.visible = false;
    ded.visible = false;
    camGame.visible = false;
    babka.camera = camHUD;
    babka.scale.set(3, 1.2);
    babka.x -= 500;
    babka.y -= 100;
    babka.updateHitbox();
    //babka.screenCenter();
    babka.alpha = 0;
    FlxG.autoPause = true;
    FlxG.cameras.add(camCut, false);
    camCut.bgColor = new FlxColor(0x00000000);
    video.load(Assets.getPath(Paths.video('кастсцена')), [':no-audio']);
    video.antialiasing = Options.antialiasing;
    //video.screenCenter();
    video.scale.set(0.7, 0.7);
    add(video);
    video.play();
    video.camera = camCut;
    camCut.alpha = 0;

    particles = new FlxTypedEmitter(-300, 1280);
    particles.loadParticles(Paths.image("burgerOpti"), 500);
	particles.scale.set(1.5, 1.5);
	particles.speed.set(250, 250);
	particles.launchAngle.set(-90, -90);
	particles.alpha.set(1, 1, 0, 0);
	particles.angle.set(-180, 30);
	particles.width = FlxG.camera.width * 3;
	particles.lifespan.set(5, 5);
    particles.blend = BlendMode.LIGHTEN;
    insert(members.indexOf(flor), particles);
	particles.start(false, 0.03);

    particles.color.set(
            0x000000,   // Начальный цвет (красный)
            0xffae00    // Конечный цвет (желтый)
        );

    //if (FlxG.physics == null) {
    //    FlxG.physics = new flixel.system.FlxPhysics();
    //}

    //FlxG.worldBounds.set(0, 0, 2000, 2000); // Установка границ мира
    //FlxG.physics.gravity.y = 500; // Гравитация вниз (положительное значение)
}

