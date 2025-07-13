import haxe.io.Path;
import flixel.util.FlxSort;
import flixel.FlxObject;
import flxanimate.frames.FlxAnimateFrames;
import funkin.backend.system.framerate.Framerate;
import funkin.savedata.FunkinSave;
import hxvlc.flixel.FlxVideoSprite;
import openfl.display.BlendMode;
var cutcene = {
    zolo:{
        sprites: "gameOverZolo",
	    animations:
	    [
	    	{
	    		name: "intro",
	    		prefix: "AnimFinal",
	    		offsets: [0, 0]
	    	}
	    ]
    }
	
}
var curCharacter:Dynamic;
importScript("data/scripts/resizing");
ratioThing(1920, 1080, true);
var video = new FlxVideoSprite(-350, -180);
var canResrt:Bool = false;

glitchShaderA = new CustomShader('GlitchShaderA');

function create() {
    camera = dieCam = new FlxCamera();
	dieCam.bgColor = FlxColor.TRANSPARENT;
	FlxG.cameras.add(dieCam, false);
    curCharacter = cutcene.zolo;
    //ivan = new AtlasSpriteSet(0, 0, curCharacter);
	//ivan.antialiasing = true;
	//add(ivan);
    //ivan.playAnimation("intro");

    video.load(Assets.getPath(Paths.video('gameovers/burger')), [':audio']);
    video.antialiasing = Options.antialiasing;
    video.scale.set(0.75, 0.75);
    add(video);
    video.scrollFactor.set(0, 0);
    video.play();
    new FlxTimer().start(6, (_) -> [
        FlxG.sound.playMusic(Paths.music('gameovers/burger'), 0, true)
        FlxG.sound.music.fadeIn(5, 0, 0.7)
        //Conductor.changeBPM(166)
        canResrt = true
    ]);

    
    video.shader = glitchShaderA;
    if(curStep < 639){
        glitchShaderA.glitchAmount = 99999999999;
    }else {
        glitchShaderA.glitchAmount = 0.0001;
    }

    statmenu = new FlxSprite(149, 23);
	statmenu.frames = Paths.getSparrowAtlas('menus/stat');
	statmenu.animation.addByPrefix('idle', "stutick0", 24, true);
	statmenu.animation.play('idle');
	statmenu.updateHitbox();
    statmenu.screenCenter();
	statmenu.antialiasing = false;
	statmenu.alpha = 0;
	statmenu.blend = BlendMode.SUBTRACT;
    statmenu.scale.set(4,4);
    add(statmenu);
}

function update() {
    if(canResrt){
        if (controls.ACCEPT){
            FlxG.sound.music.fadeIn(0.1, 0, 0);
            FlxG.sound.play(Paths.sound("menu/new/enter"), 0.7);
            canResrt = false;
            FlxTween.tween(statmenu, {alpha:1}, 3, {ease: FlxEase.quintOut});
            new FlxTimer().start(2.5, (_) -> [
                FlxG.switchState(new PlayState())
            ]);
        }else if (controls.BACK){
            FlxG.switchState(new MainMenuState());
        }
    }
	
}

function destroy() {
	
}
class AtlasSpriteSet extends FlxAnimate
{
	public var char:Dynamic;

	public function new(x:Float, y:Float, char:Dynamic)
	{
		this.char = char;
		super(x, y);

		var path = 'atlas/' + char.sprites;
		var animPath = Path.withoutExtension(Paths.image(path));

		anim._loadAtlas(atlasSetting(animPath));
		this.frames = FlxAnimateFrames.fromTextureAtlas(animPath);
	}

	public function playAnimation(name:String):Void
	{
		for (animData in char.animations)
		{
			if (animData.name == name)
			{
				anim.play(animData.prefix, false);
				if (animData.offsets != null && animData.offsets.length == 2)
				{
					offset.set(animData.offsets[0], animData.offsets[1]);
				}
				else
				{
					offset.set();
				}
				return;
			}
		}
		trace('Animation "' + name + '" not found!');
	}
}
