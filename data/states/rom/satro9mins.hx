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
	txt0 = new FlxText(0,0,FlxG.height + 400, "Пока тут нечего нет\nждите 1.5\n(P.S Тут будет миниигра)", 32);
    txt0.setFormat(Paths.font("1papyrus.ttf"), 30, FlxColor.white, 'center');
    txt0.screenCenter();
    add(txt0);
    //не удивляйтесь, я долбаеб - NikkiRemo
    
}
function update(elapsed:Float) {
    //trace(video.bitmap.bitmapData);
    if(controls.ACCEPT || controls.BACK){
        FlxG.switchState(new FreeplayState());
    }
    
}