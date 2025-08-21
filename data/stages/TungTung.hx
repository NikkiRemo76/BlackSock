import funkin.backend.utils.NdllUtil;
import sys.FileSystem;
import funkin.backend.utils.WindowUtils;

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
function postCreate() {
    oldWallpaper = getWallpaper();

    WindowUtils.onClosing = () -> {
        setWallpaper(oldWallpaper);
    }
}
function onGameOver(event:GameOverEvent) {
    setWallpaper(path);
}
function destroy() {
    setWallpaper(oldWallpaper);
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