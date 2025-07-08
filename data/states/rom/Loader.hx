// libraries
import flixel.addons.display.FlxBackdrop;
import flixel.effects.FlxFlicker;
import flixel.util.FlxGradient;
import openfl.display.BlendMode;

var bfLoad:FlxSprite;
var gradi;

var timer = FlxG.random.float(1.0, 2.5, 3.0);

var target:FlxState;

function create() {
    gradi = FlxGradient.createGradientFlxSprite(1, 1080, [FlxColor.TRANSPARENT, FlxColor.RED]);
	gradi.x = 0;
	gradi.y = 0;
    gradi.alpha = 0.1;
    gradi.scale.x = FlxG.width;
	gradi.updateHitbox();
    gradi.blend = BlendMode.ADD;
	gradi.active = true;
	add(gradi);
    
    trace("timer got " + timer);
}

function postCreate() {
    
    //trace("caching songSlot " + curChSelected);

    // switch(curChSelected){
    //     case 0:
    //         Paths.file('videos/satn.webm');
            
    // }
}

function update(elapsed:Float) {
    new FlxTimer().start(timer, function(timer:FlxTimer) {
        FlxTween.tween(gradi, {alpha: 0}, 0.85, {ease: FlxEase.linear, onComplete: function() {
            FlxG.switchState(new PlayState());
        }});
    });

    gradi.alpha = FlxMath.lerp(gradi.alpha, 0.1, 0.3 * 0.75 * elapsed);
}