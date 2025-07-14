import flixel.effects.particles.FlxEmitter.FlxTypedEmitter;
import openfl.display.BlendMode;
import flixel.text.FlxTextBorderStyle;
//import TitleState;
function create() {
    if(FlxG.save.data.curWackyfile == 'windings'){
        heatShader = new CustomShader('White');
        FlxG.camera.addShader(heatShader);
    }

    trace(FlxG.save.data.curWackyfile);
    
    menu = new FlxSprite(149, 23);
	menu.frames = Paths.getSparrowAtlas('menus/title/testSparow');
	menu.animation.addByPrefix('idle', "assets", 24, true);
    menu.animation.play('idle');
    menu.updateHitbox();
    menu.screenCenter();
	menu.alpha = 1;
    menu.scale.set(3,3);
    menu.scrollFactor.set(0.5, 0.5);
    add(menu);

    textCre = new FlxText(0, 0, 0, 'MC.Yug_i (aka.yugiguyi) - Музыка\nSani4ka ya Punkul - Чарт\nB3br1z - Спрайты\nShinigami - Арт\nNikkiRemo - Код\n\n\nСпасибо что сыграли в Демо\nBlack Sock team', 60, true);
    textCre.setFormat(Paths.font("1papyrus.ttf"), 50);
    textCre.alignment = 'center';
    textCre.updateHitbox();
    textCre.screenCenter();
    //textCre.borderSize = 1.25;
    textCre.y = 900;
	add(textCre);

    logo = new FlxSprite(0, 0);
    logo.loadGraphic(Paths.image('menus/title/logoCompres'), false, 100, 100); // Замените на свой спрайт
    logo.scale.set(0.6, 0.6);
    logo.updateHitbox();
    logo.screenCenter();
    logo.visible = true;
	add(logo);

    particles = new FlxTypedEmitter(-300, 1280);
    particles.loadParticles(Paths.image("menus/title/texture"), 500);
	particles.scale.set(0.2, 0.2);
	particles.speed.set(250, 250);
	particles.launchAngle.set(-90,-90);
	particles.alpha.set(1, 1, 0, 0);
	particles.angle.set(-180, 30);
	particles.width = FlxG.camera.width * 3;
	particles.lifespan.set(6, 4);
    particles.blend = BlendMode.LIGHTEN;
	add(particles);
	particles.start(false, 0.03);

    particles.color.set(
            0xff7b00,   // Начальный цвет (красный)
            0xff0000    // Конечный цвет (желтый)
    );
    FlxG.sound.music.fadeOut(30, 0, 0);
}

function update(elapsed:Float) {
    textCre.y -= 0.2;
    if(textCre.y < 720){
        logo.y -= 0.2;
    }
    if(controls.ACCEPT || controls.BACK || textCre.y< -720){
        FlxG.switchState(new FreeplayState());
    }
    
}