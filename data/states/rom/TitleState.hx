import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;
import openfl.display.BlendMode;
import flixel.math.FlxRandom;

var camBG:FlxCamera = new FlxCamera();
var camMenu:FlxCamera = new FlxCamera();
var camUI:FlxCamera = new FlxCamera();

var random:FlxRandom = new FlxRandom();

var curWacky:Array<String> = [];
var transitioning:Bool = true;
function create() {

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
    title.y += 425;
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
    uiAssets.add(introText);

    new FlxTimer().start(2, (_) -> 
    [FlxTween.tween(introText, {alpha:0}, 1.4, {ease: FlxEase.quintOut})
    transitioning = false
    FlxTween.tween(title, {alpha:1}, 1.4, {ease: FlxEase.quintOut})]);
}

var localTime:Float = 0;

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
            
	        FlxTween.tween(statmenu, {alpha:1}, 1.4, {ease: FlxEase.quintOut});
            FlxG.sound.music.fadeIn(0.1, 0, 0);
            transitioning = true;
			//trace("m,dms,hdsjklljhvkdlhvgjkfdlvnjkfdojn");
			FlxG.sound.play(Paths.sound("menu/enter"), 0.7);
			//CoolUtil.playMenuSFX("menu/confirm");
			new FlxTimer().start(1.4, (_) -> [
            PlayState.loadSong('burger', 'burger')
            FlxG.switchState(new PlayState())]);
		}
	}
}