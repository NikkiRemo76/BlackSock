importScript("data/scripts/resizing");
ratioThing(1000, 1000, false);
import hxvlc.flixel.FlxVideoSprite;
import openfl.display.BlendMode;
function postCreate() {
    trans = new FlxSprite();
	trans.frames = Paths.getSparrowAtlas('menus/cam eff');
	trans.animation.addByPrefix('idle', 'anim0', 27, true);
	trans.scale.x = 2.1;
    trans.scale.y = 2.1;
	trans.updateHitbox();
    trans.screenCenter();
	//trans.scrollFactor.set();
    trans.camera = camHUD;
    trans.blend = BlendMode.ADD;
	add(trans);
    trans.animation.play('idle');

	trans1 = new FlxSprite();
	trans1.frames = Paths.getSparrowAtlas('menus/ui');
	trans1.animation.addByPrefix('idle', '0', 2, true);
	trans1.scale.x = 1.7;
    trans1.scale.y = 1.7;
	trans1.updateHitbox();
    trans1.screenCenter();
	//trans.scrollFactor.set();
    trans1.camera = camHUD;
    trans1.blend = BlendMode.ADD;
	add(trans1);
    trans1.animation.play('idle');

    stati = new FlxSprite(149, 23);
	stati.frames = Paths.getSparrowAtlas('menus/stat');
	stati.animation.addByPrefix('idle', 'stutick', 27, true);
    stati.animation.play('idle');
	stati.updateHitbox();
	stati.antialiasing = false;
	stati.blend = BlendMode.SUBTRACT;
	stati.scale.set(2, 2);
    add(stati);
	//stati.scrollFactor.set();
    stati.camera = camHUD;
	stati.screenCenter();
}

function update(elapsed:Float) {
    //trace(1.0 - (health/3.0));
    stati.alpha = 0.5 - (health/3.0);
}

function destroy(){
    ratioThing(1280, 720, true);
}