import FlxSprite;
import Sys;
import flixel.effects.FlxFlicker;
import flixel.math.FlxRect;
import flixel.tweens.FlxTweenManager;
import funkin.backend.Conductor;
import openfl.utils.Assets;

function postUpdate(elapsed:Float) {
    var elapsed = elapsed;
	skipUpdate(elapsed);
}
var canSkip = false;
var skipStep:Float;
var skipBG = new FlxSprite();
var skipBar = new FlxSprite();
var skipProg:Float = 0;
var skipGoal = 3.0;

var skipcam:FlxCamera;
function create() {

    skipcam = new FlxCamera();
	FlxG.cameras.add(skipcam, false);
    skipcam.bgColor = 0;

    skipBG.makeGraphic(FlxG.width / 4, 20, FlxColor.WHITE);
	skipBar.makeGraphic(FlxG.width / 4, 20, FlxColor.WHITE);
	skipBar.alpha = skipBG.alpha = 0;
	skipBG.cameras = skipBar.cameras = [skipcam];
	skipBG.screenCenter();
	skipBar.screenCenter();
	skipBG.y = skipBar.y = 600;
	add(skipBG);
	add(skipBar);
    new FlxTimer().start(0.1, (t:FlxTimer) -> trace("Created " + eventArray.length + " events"));
}
public static function queSkip(_step:Int) {
	canSkip = true;
	skipStep = _step;

	var skipNotif = new FlxSprite(800, 300);
	skipNotif.frames = Paths.getFrames('skipNotif');
	skipNotif.animation.addByPrefix('notif', 'ANAL SKIP', 24, false);
	skipNotif.animation.play('notif');
	skipNotif.cameras = [skipcam];
	add(skipNotif);

	new FlxTimer().start(3.1, () -> remove(skipNotif));
}
var tweenProg:FlxTween;
function skipUpdate(elapsed:Float) {
	if(FlxG.keys.pressed.Z && canSkip && skipBar.alpha < 1) {
		if(skipBG.alpha < 0.25) skipBG.alpha += 1 * elapsed;
		if(skipBar.alpha < 1) skipBar.alpha += 4 * elapsed;
	} else if(skipBar.alpha > 0) {
		if(skipBG.alpha > 0) skipBG.alpha -= 0.3 * elapsed;
		if(skipBar.alpha > 0) skipBar.alpha -= 1 * elapsed;
	}

	// Смешные твины на прогрессБар
	if (canSkip) {
		if(FlxG.keys.justPressed.Z) {
			tweenProg?.cancel();
			tweenProg = FlxTween.num(skipProg, skipGoal, 5, {ease: FlxEase.cubeOut}, (a) -> skipProg = a);
		} else if (FlxG.keys.justReleased.Z) {
			tweenProg?.cancel();
			tweenProg = FlxTween.num(skipProg, 0, 1, {ease: FlxEase.bounceOut}, (a) -> skipProg = a);
		}
	} else if (tweenProg == null) tweenProg = FlxTween.num(skipProg, 0, 1, {ease: FlxEase.cubeOut}, (a) -> skipProg = a);

	if(skipProg >= skipGoal && canSkip) {
		doSkip();
		tweenProg = null;
	}
	if(skipBar.alpha > 0) skipBar.clipRect = new FlxRect(0, 0, skipProg / skipGoal * skipBar.width, skipBar.height);
}

static function doSkip() {
	FlxG.sound.music.pause();
	vocals.pause();
	FlxG.sound.music.time = skipStep * Conductor.stepCrochet;
	vocals.time = skipStep * Conductor.stepCrochet;
	FlxG.sound.music.play();
	vocals.play();
	
	//Если этого не сделать и во время катсцены идут ноты (хотя захуя тогда скипать? вопрос хороший) то тебя убьёт
	for(sl in strumLines)
		for(note in sl.notes.members)
			if(note.strumTime < skipStep * Conductor.stepCrochet) note.mustPress = false;
	
	//Избавляемся от лишних ивентов. На всякий случай
	for(e in eventArray) if(e.step < skipStep) eventArray.remove(e, true);

	canSkip = false;
}

var eventArray:Array<StepEvent> = [];
public static function makeEvent(step:Int, callback:Void->Void)
	return eventArray.push(new StepEvent(step, callback));

public static function multipleEvent(steps:Array<Int>, callback:Void->Void)
	return for (i in steps) eventArray.push(new StepEvent(i, callback));

function stepHit(step:Int)
	if (eventArray != null)
		for (e in eventArray)
			if (e != null)
				if (step >= e.step) {
					e.callback();
					eventArray.remove(e);
				}