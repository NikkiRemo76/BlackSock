import openfl.display.BlendMode;
import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;
function create() {
    title = new FlxSprite(149, 23);
	title.frames = Paths.getSparrowAtlas('menus/title/titleROM');
	title.animation.addByPrefix('idle', "titlerROM0", 24, true);
	title.animation.play('idle');
	title.updateHitbox();
    title.screenCenter();
	title.antialiasing = false;
    add(title);
	if (FlxG.sound.music == null)
		FlxG.sound.playMusic(Paths.music('freakyMenu'), 0, true);

	if (FlxG.sound.music != null && FlxG.sound.music.volume == 0) {
		FlxG.sound.music.fadeIn(5, 0, 0.7);
		FlxG.sound.music.play();
	}

	//random = new FlxSprite(0, 0).loadGraphic(Paths.image('NewCanvas2ttgtg'));
	//random.blend = BlendMode.LIGHTEN;
	//add(random);

	stat = new FlxSprite(149, 23);
	stat.frames = Paths.getSparrowAtlas('menus/stat');
	stat.animation.addByPrefix('idle', "stutick0", 24, true);
	stat.animation.play('idle');
	stat.updateHitbox();
    stat.screenCenter();
	stat.antialiasing = false;
	stat.alpha = 1;
	stat.blend = BlendMode.SUBTRACT;
	stat.scale.set(3,3);
    add(stat);
	FlxTween.tween(stat, {alpha:0}, 1, {ease: FlxEase.quintOut});
}
var transitioning:Bool = false;
function update(elapsed:Float) {
	if (FlxG.keys.justPressed.SEVEN) {
		openSubState(new EditorPicker());
	}

	if (FlxG.keys.justPressed.TAB) {
		openSubState(new ModSwitchMenu());
	}
    var pressedEnter:Bool = FlxG.keys.justPressed.ENTER;
	var pressedSpace:Bool = FlxG.keys.justPressed.SPACE;
    if (pressedEnter || pressedSpace) {
		if (!transitioning){
            transitioning = true;
			//trace("m,dms,hdsjklljhvkdlhvgjkfdlvnjkfdojn");
			FlxG.sound.play(Paths.sound("menu/confirm"), 0.7);
			CoolUtil.playMenuSFX("menu/confirm");
			new FlxTimer().start(1.4, (_) -> FlxG.switchState(new FreeplayState()));
		}
	}
}