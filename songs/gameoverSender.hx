//hope
function onGameOver(e){
    PlayState.defaultCamZoom = 0.8;
    camGame.visible = true;
    camGame.setFilters();
    e.cancel();
    if (PlayState.character != null)
        PlayState.character.stunned = true;

    persistentUpdate = false;
    persistentDraw = false;
    paused = true;

    vocals.stop();
    if (FlxG.sound.music != null)
        FlxG.sound.music.stop();

    // trace(PlayState.SONG.meta.name.toLowerCase() + gameOverPrefix);
    //trace(gameOverPostfix);
    if (hasGameOver){
        openSubState(new ModSubState('substates/gameOvers/' + PlayState.SONG.meta.name.toLowerCase()/* + gameOverPostfix*/));
    }else {
        openSubState(new ModSubState('substates/gameOvers/placeHolder'));
    }
    
}
