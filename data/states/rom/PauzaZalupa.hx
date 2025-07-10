import hxvlc.flixel.FlxVideoSprite;
import flixel.effects.FlxFlicker;
import openfl.display.BlendMode;
import funkin.game.PlayState;
import funkin.options.OptionsMenu;
import funkin.backend.MusicBeatState;
import funkin.menus.PauseSubState;

var pauzeCam = new FlxCamera();

function create(e) {
	camera = pauzeCam;
    pauzeCam.bgColor = 0;

	FlxG.cameras.add(pauzeCam, false);

	pauzeCam.zoom = 0.3;
	FlxTween.tween(pauzeCam, {zoom: 1}, 1.3, {ease: FlxEase.expoOut});
}

function onClose() {

}

function destroy() {
    
}

function update(elapsed:Float) {
    
}

function change_select(le:Int) {
    
}

function accepted() {
    
}

function spawn_song_art() { 
    
}
