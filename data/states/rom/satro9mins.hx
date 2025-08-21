import hxvlc.flixel.FlxVideoSprite;

var start = true;
var video = new FlxVideoSprite(400, 200);


function getIntroTextShit():Array<Array<String>>
{
	var fullText:String = Paths.getFolderContent('videos/fun/', false);
	var firstArray:Array<String> = fullText;
	var swagGoodArray:Array<Array<String>> = [];
	for (i in firstArray)
	{
		swagGoodArray.push(i.split('.mp4'));
	}
	return swagGoodArray;
}

var videos:Array<String> = FlxG.random.getObject(getIntroTextShit());

function postCreate() {
    trace(videos);
    //trace(getIntroTextShit());
	FlxG.sound.play(Paths.sound('satro 9mins'));
    video.load(Assets.getPath(Paths.video('fun/' + FlxG.random.getObject(videos))), ['audio']);
    video.load(Assets.getPath(Paths.video('fun/' + FlxG.random.getObject(videos))), ['audio']);
    video.load(Assets.getPath(Paths.video('fun/' + FlxG.random.getObject(videos))), ['audio']);
    video.load(Assets.getPath(Paths.video('fun/' + FlxG.random.getObject(videos))), ['audio']);
    video.load(Assets.getPath(Paths.video('fun/' + FlxG.random.getObject(videos))), ['audio']);
    video.load(Assets.getPath(Paths.video('fun/' + FlxG.random.getObject(videos))), ['audio']);
    video.load(Assets.getPath(Paths.video('fun/' + FlxG.random.getObject(videos))), ['audio']);
    video.load(Assets.getPath(Paths.video('fun/' + FlxG.random.getObject(videos))), ['audio']);
    video.play();
    video.scale.set(2.5, 2.5);
    add(video);
    //не удивляйтесь, я долбаеб - NikkiRemo
    
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
    [FlxG.switchState(new FreeplayState()),
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