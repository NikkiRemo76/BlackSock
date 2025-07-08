
function create() {
    oneTxt = new Alphabet(0, 0, "WARNINGWARNINGWARNINGWARNINGWARNINGWARNINGWARNINGWARNINGWARNINGWARNINGWARNINGWARNINGWARNINGWARNINGWARNINGWARNINGWARNINGWARNINGWARNING", true);
    oneTxt.screenCenter();
    oneTxt.y -= 140;
    add(oneTxt);

    txt0 = new FlxText(0,0,FlxG.height + 400, "Эпилепсия и все такое", 32);
    txt0.setFormat(Paths.font("1papyrus.ttf"), 30, FlxColor.white, 'center');
    txt0.screenCenter();
    txt0.y = oneTxt.y + 80;
    txt0.x -= 50;
    add(txt0);

    txt = new FlxText(0,0,FlxG.height + 400, "ну вы шарите", 32);
    txt.setFormat(Paths.font("1papyrus.ttf"), 30, FlxColor.white, 'center');
    txt.screenCenter();
    txt.y = oneTxt.y + 135;
    add(txt);

    txt2 = new FlxText(0,0,FlxG.height + 400, "да?", 32);
    txt2.setFormat(Paths.font("1papyrus.ttf"), 30, FlxColor.white, 'center');
    txt2.screenCenter();
    txt2.y = txt.y + 80;
    add(txt2);

    txt3 = new FlxText(0,0,FlxG.height + 400, "кароч, съебись если ты эпилептик", 32);
    txt3.setFormat(Paths.font("1papyrus.ttf"), 30, FlxColor.white, 'center');
    txt3.screenCenter();
    txt3.y = txt2.y + 120;
    add(txt3);

    txt4 = new FlxText(0,0,FlxG.height + 400, "либо нажми энтр если ты не педик", 32);
    txt4.setFormat(Paths.font("1papyrus.ttf"), 30, FlxColor.white, 'center');
    txt4.screenCenter();
    txt4.y = txt3.y + 80;
    add(txt4);

    heatShader = new CustomShader('heatShader');
    FlxG.camera.addShader(heatShader);
}
var press:Bool = true;
var localTime:Float = 0;
function update(elapsed:Float)
{
    localTime += elapsed;
    heatShader.iTime = localTime;
    
    if (!press) return;
    
    if (controls.ACCEPT) { 
        press = false;
        FlxG.sound.play(Paths.sound("menu/enter"), 1);
		FlxG.camera.flash(FlxColor.WHITE, 1, function() {
			FlxG.switchState(new ModState("rom/TitleState"));
		});
    }
}