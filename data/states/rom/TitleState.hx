import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;
import openfl.display.BlendMode;
import flixel.math.FlxRandom;
import flixel.addons.display.FlxBackdrop;
import flixel.effects.particles.FlxEmitter.FlxTypedEmitter;

var camBG:FlxCamera = new FlxCamera();
var camMenu:FlxCamera = new FlxCamera();
var camUI:FlxCamera = new FlxCamera();

var random:FlxRandom = new FlxRandom();

var curWacky:Array<String> = [];
var transitioning:Bool = true;
function create() {
    FlxG.sound.music = null;
    if (FlxG.sound.music == null)
		FlxG.sound.playMusic(Paths.music('freakyMenu'), 0, true);

	if (FlxG.sound.music != null && FlxG.sound.music.volume == 0) {
		FlxG.sound.music.fadeIn(5, 0, 0.7);
		FlxG.sound.music.play();
	}

    FlxG.cameras.add(camBG, false);
    camBG.bgColor = new FlxColor(0x00000000);

    FlxG.cameras.add(camMenu, false);
    camMenu.bgColor = new FlxColor(0x00000000);

    FlxG.cameras.add(camUI, false);
    camUI.bgColor = new FlxColor(0x00000000);

    menuAssets = new FlxGroup();
	add(menuAssets);
    menuAssets.cameras = [camMenu];

    bgAssets = new FlxGroup();
	add(bgAssets);
    bgAssets.cameras = [camBG];

    uiAssets = new FlxGroup();
	add(uiAssets);
    uiAssets.cameras = [camUI];

    FlxG.camera = camBG;

    heatShader = new CustomShader('heatShader');
    camBG.addShader(heatShader);
    camMenu.addShader(heatShader);

    menu = new FlxSprite(149, 23);
	menu.frames = Paths.getSparrowAtlas('menus/title/testSparow');
	menu.animation.addByPrefix('idle', "assets", 24, true);
    menu.animation.play('idle');
    menu.updateHitbox();
    menu.screenCenter();
	menu.alpha = 1;
    menu.scale.set(3,3);
    menu.scrollFactor.set(0.5, 0.5);
    bgAssets.add(menu);

    logo = new FlxSprite(FlxG.width / 2 - 50, FlxG.height / 2 - 100);
    logo.loadGraphic(Paths.image('menus/title/logo'), false, 100, 100); // Замените на свой спрайт
    logo.scale.set(0.1, 0.1);
    logo.updateHitbox();
    logo.screenCenter();
    logo.visible = true;
    menuAssets.add(logo);

    title = new FlxSprite(FlxG.width / 2 - 50, FlxG.height / 2 - 100);
    title.loadGraphic(Paths.image('menus/title/image'), false, 100, 100); // Замените на свой спрайт
    title.scale.set(0.6, 0.2);
    title.updateHitbox();
    title.y += 415;
    title.x -= 600;
    title.visible = true;
    title.antialiasing = false;
    title.alpha = 0;
    uiAssets.add(title);

    statmenu = new FlxSprite(149, 23);
	statmenu.frames = Paths.getSparrowAtlas('menus/stat');
	statmenu.animation.addByPrefix('idle', "stutick0", 24, true);
	statmenu.animation.play('idle');
	statmenu.updateHitbox();
    statmenu.screenCenter();
	statmenu.antialiasing = false;
	statmenu.alpha = 0;
	statmenu.blend = BlendMode.SUBTRACT;
    statmenu.scale.set(3,3);
    uiAssets.add(statmenu);

    curWacky = FlxG.random.getObject(CoolUtil.coolTextFile(Paths.txt("logoTexts")));

    //trace(curWacky);
    introText = new FlxSprite(149, 23);
    introText.frames = Paths.getSparrowAtlas('menus/title/texts/' + curWacky);
    introText.animation.addByPrefix('idle', curWacky, 24, true);
    introText.animation.play('idle');
    introText.updateHitbox();
    introText.screenCenter();
    introText.scale.x = Math.min(1, 980 / introText.width);
    introText.antialiasing = false;
    //introText.blend = BlendMode.LIGHTEN;
    uiAssets.add(introText);

    new FlxTimer().start(2, (_) -> 
    [FlxTween.tween(introText, {alpha:0}, 1.4, {ease: FlxEase.quintOut})
    transitioning = false
    FlxTween.tween(title, {alpha:1}, 1.4, {ease: FlxEase.quintOut})]);

    if(curWacky =='masteeeeerd'){
        mas = new FlxSprite(FlxG.width / 2 - 50, FlxG.height / 2 - 100);
        mas.loadGraphic(Paths.image('masteeeeerd'), false, 100, 100); // Замените на свой спрайт
        mas.scale.set(1, 1);
        mas.updateHitbox();
        mas.screenCenter();
        mas.visible = true;
        menuAssets.add(mas);
        FlxTween.tween(mas, {alpha:0}, 5, {ease: FlxEase.quintOut});
        FlxG.sound.play(Paths.sound("masteeeeerd"), 0.7);
    }

    textCre = new FlxText(0, 0, 0, 'MC.Yug_i (aka.yugiguyi), sani4ka_ya_punkul, B3br1z, NikkiRemo, Ерих, ', 60, true);
    textCre.font = Paths.font("1papyrus.ttf");
    textCre.updateHitbox();
    textCre.visible = false;
	uiAssets.add(textCre);

    backDrop = new FlxBackdrop(textCre.pixels, 1,0);
    backDrop.scale.set(1, 1);
    backDrop.velocity.x = -100;
    uiAssets.add(backDrop);

    particles = new FlxTypedEmitter(-300, 1280);
    particles.loadParticles(Paths.image("menus/title/texture"), 500);
	particles.scale.set(0.2, 0.2);
	particles.speed.set(250, 250);
	particles.launchAngle.set(-90, -90);
	particles.alpha.set(1, 1, 0, 0);
	particles.angle.set(-180, 30);
	particles.width = FlxG.camera.width * 3;
	particles.lifespan.set(5, 5);
    particles.blend = BlendMode.LIGHTEN;
	menuAssets.add(particles);
	particles.start(false, 0.03);

    particles.color.set(
            0xff0000,   // Начальный цвет (красный)
            0xffae00    // Конечный цвет (желтый)
        );

    fg = new FlxSprite(149, 23);
	fg.frames = Paths.getSparrowAtlas('menus/title/firefg');
	fg.animation.addByPrefix('idle', "firefg", 24, true);
    fg.animation.play('idle');
    fg.updateHitbox();
    fg.screenCenter();
	fg.alpha = 0.5;
    fg.scale.set(5,5);
    fg.scrollFactor.set(0.5, 0.5);
    fg.blend = BlendMode.LIGHTEN;
    menuAssets.add(fg);

    

}

var localTime:Float = 0;

function postCreate() {
    if(FlxG.save.data.songFinished100){
        onSongFinished();
    }

    trace(FlxG.save.data.songFinished100);
}

function update(elapsed:Float) {
    //Shaders
    localTime += elapsed;
    heatShader.iTime = localTime;
    //Shader end
    camMenu.scroll.x = FlxMath.lerp(camMenu.scroll.x, (FlxG.mouse.screenX-(FlxG.width/2)) * 0.015, (1/30)*240*elapsed);
	camMenu.scroll.y = FlxMath.lerp(camMenu.scroll.y, (FlxG.mouse.screenY-6-(FlxG.height/2)) * 0.015, (1/30)*240*elapsed);

    camBG.scroll.x = FlxMath.lerp(camBG.scroll.x, (FlxG.mouse.screenX-(FlxG.width/2)) * 0.015, (1/30)*240*elapsed);
	camBG.scroll.y = FlxMath.lerp(camBG.scroll.y, (FlxG.mouse.screenY-6-(FlxG.height/2)) * 0.015, (1/30)*240*elapsed);

	if (FlxG.keys.justPressed.SEVEN) {
		openSubState(new EditorPicker());
	}

	if (FlxG.keys.justPressed.TAB) {
		openSubState(new ModSwitchMenu());
	}
    var pressedEnter:Bool = FlxG.keys.justPressed.ENTER;
	var pressedSpace:Bool = FlxG.keys.justPressed.SPACE;
    if (pressedEnter || pressedSpace) {
		if (!transitioning){
            
            FlxG.sound.music.fadeIn(0.1, 0, 0);
	        FlxTween.tween(statmenu, {alpha:1}, 5, {ease: FlxEase.quintOut});
            transitioning = true;
			//trace("m,dms,hdsjklljhvkdlhvgjkfdlvnjkfdojn");
			FlxG.sound.play(Paths.sound("menu/enter"), 0.7);
			//CoolUtil.playMenuSFX("menu/confirm");
			new FlxTimer().start(1.4, (_) -> [
            
            PlayState.loadSong('burger', 'burger')
            PlayState.isStoryMode = true
		    PlayState.storyWeek = {
		    	name: 'burger',
		    	id: '',
		    	sprite: null,
		    	chars: [null, null, null],
		    	songs: [],
		    	difficulties: ['burger']
		    }
            FlxG.switchState(new ModState('rom/Loader'))]);
            //FlxG.switchState(new PlayState())]);
		};
	}
}

function onSongFinished() {
    FlxG.switchState(new ModState('rom/cutsene'));
}