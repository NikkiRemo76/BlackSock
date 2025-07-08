import Sys;
//function postCreate() {
//	masteeeeerd = new FlxSprite();
//    masteeeeerd.loadGraphic(Paths.image('masteeeeerd'), false, 100, 100); // Замените на свой спрайт
//    add(masteeeeerd);
//}
function update(elapsed:Float) {
	if (FlxG.keys.justPressed.EIGHT) {
		FlxG.camera.zoom = -1;
		FlxG.sound.play(Paths.sound("masteeeeerd"), 0.7);
	}
}

