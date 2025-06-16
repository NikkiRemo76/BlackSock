import funkin.backend.MusicBeatSubstate;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxGradient;
import openfl.display.BlendMode;

//static var loadingPlayState = true;
var transCam:FlxCamera;

var gradiTransition:FlxGradient;

function postCreate()
{
	var out = newState != null;
	//if (newState is PlayState)
	//loadingPlayState = true;

	remove(blackSpr);
	remove(transitionSprite);

	transCam = new FlxCamera();
	transCam.bgColor = 0;
	FlxG.cameras.add(transCam, false);

	stat = new FlxSprite(149, 23);
	stat.frames = Paths.getSparrowAtlas('menus/tren');
	stat.animation.addByPrefix('intro', 'intro', 27, false);
	stat.animation.addByPrefix('outro', 'outro', 27, false);
	stat.updateHitbox();
	stat.antialiasing = false;
	stat.alpha = 1;
	stat.blend = BlendMode.SUBTRACT;
	stat.scale.set(2, 2);
    add(stat);
	stat.scrollFactor.set();
	stat.screenCenter();

	if (!out)
	{
		stat.flipY = true;
		stat.animation.play('outro');
	}
	else 
	{
		stat.animation.play('intro');

		transitionTween.onComplete = function(twn)
		{
			if (FlxG.state is PlayState)
				finish(); //stops crashes for now
			else
				nextFrameSkip = true;
		}
	}
}
//function postUpdate(elapsed:Float) {
//	blackShader.trash += 0.01;
//}