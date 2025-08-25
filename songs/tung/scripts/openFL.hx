import lime.system.System;

function onSongEnd() {
    if(!FlxG.save.data.twitchMod){
        System.openFile("mods/BlackSock/data/game/тун тун пиздун игра.exe");
    }
    
}