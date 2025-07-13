function create() {
    mujik = new FlxSprite(FlxG.width / 2 - 50, FlxG.height / 2 - 100);
    mujik.frames = Paths.getSparrowAtlas('menus/title/estet/estetmujik');
    mujik.animation.addByPrefix('idle', "mujik", 24, true);
    mujik.animation.play('idle');
    mujik.scale.set(0.8, 0.8);
    mujik.updateHitbox();
    mujik.screenCenter();
    mujik.visible = true;
    mujik.scrollFactor.set(0, 0);
    add(mujik);
}

function update() {
	if (controls.ACCEPT)
	    FlxG.switchState(new PlayState());
    else if (controls.BACK)
	    FlxG.switchState(new MainMenuState());
}

function destroy() {
	
}