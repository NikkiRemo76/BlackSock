import hxvlc.flixel.FlxVideoSprite;

var video = new FlxVideoSprite(-300, -200);
function create() {
	//importScript("data/scripts/resizing");
	FlxG.autoPause = true;
    ratioThing(1280, 720, false);
	video.load(Assets.getPath(Paths.video('curscene')), 'audio');
    video.play();
    add(video);
}

function destroy() {
	close();
	FlxG.switchState(new TitleState());
}