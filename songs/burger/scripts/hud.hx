import flixel.ui.FlxBar;
import flixel.text.FlxTextBorderStyle;

var ratingFC:String = '';

var sicks:Int = 0;
var goods:Int = 0;
var bads:Int = 0;
var shits:Int = 0;

var scoreTxtTween:FlxTween;

function postCreate(){
    for(i in [healthBar, healthBarBG, scoreTxt, missesTxt, accuracyTxt]) remove(i);
    iconP1.visible = false;
    iconP2.visible = false;

    barBG = new FlxSprite(350, 60.5).loadGraphic(Paths.image('game/batareika/line'));
    barBG.camera = camHUD;
    barBG.updateHitbox();
    barBG.scale.set(2.5, 2.5);
    add(barBG);

    healthBar = new FlxBar(barBG.x, barBG.y, FlxBar.LEFT_TO_RIGHT, barBG.width, barBG.height, this, 'health', 0, maxHealth);
    healthBar.createImageBar(Paths.image('game/batareika/empty'), Paths.image('game/batareika/fill'));
    healthBar.camera = camHUD;
    healthBar.numDivisions = 50;
    healthBar.updateHitbox();
    healthBar.x -= 4.5;
    healthBar.y -= 5.6;
    healthBar.scale.set(barBG.scale.x, barBG.scale.y);
    add(healthBar);

}
function update(elapsed:Float) {
    if (health < 0.3){
        healthBar.color = 0xff0000;
    }else{
        healthBar.color = 0xffffff;
    }
}