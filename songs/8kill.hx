import Sys;
function update(elapsed:Float) {
	if (FlxG.keys.justPressed.EIGHT) {
		//Sys.exit(0);
		PlayState.loadSong('INTERVIU', 'aaaa');
		FlxG.switchState(new PlayState());
	}
}

