import hxvlc.flixel.FlxVideoSprite;

var start = true;
var video = new FlxVideoSprite(400, 200);
function create() {
    video.load(Assets.getPath(Paths.video('curscene')), 'audio');
    video.play();
    //video.screenCenter();
    video.scale.set(2.5, 2.5);
    add(video);
    
}
function collFunk() {
    FlxG.sound.music.fadeIn(0.1, 0, 0);
    start = false;
    FlxG.save.data.songFinished100 = false;
    new FlxTimer().start(50, (_) -> 
    [FlxG.switchState(new TitleState())
    FlxG.sound.playMusic(null, 0, true)]);
}
function update(elapsed:Float) {
    //trace(video.bitmap.bitmapData);
    if(video.bitmap.bitmapData != null && start){
        collFunk();
    }
}