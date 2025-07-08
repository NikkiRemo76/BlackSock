import hxvlc.flixel.FlxVideoSprite;

var start = true;
var video = new FlxVideoSprite(400, 200);
function create() {
    
	FlxG.sound.play(Paths.sound('satro 9mins'));
    video.load(Assets.getPath(Paths.video('Untitled')), ['audio']);
    video.play();
    video.scale.set(2.5, 2.5);
    add(video);
    
}
function collFunk() {
    var scale:Float = Math.min(FlxG.width / video.bitmap.bitmapData.width, FlxG.height / video.bitmap.bitmapData.height);
    video.setGraphicSize(video.bitmap.bitmapData.width * scale, video.bitmap.bitmapData.height * scale);
    video.updateHitbox();
    
    video.screenCenter();
    FlxG.sound.music.fadeIn(0.1, 0, 0);
    start = false;
    FlxG.save.data.songFinished100 = false;
    new FlxTimer().start(85, (_) -> 
    [FlxG.switchState(new FreeplayState())
    FlxG.sound.playMusic(null, 0, true)]);
}
function update(elapsed:Float) {
    //trace(video.bitmap.bitmapData);
    if(video.bitmap.bitmapData != null && start){
        collFunk();
    }
    if(controls.ACCEPT || controls.BACK){
        FlxG.switchState(new FreeplayState());
    }
    
}