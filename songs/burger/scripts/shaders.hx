glitchA = new CustomShader('Aura');
redpal = new CustomShader('Red');
glitchShaderA = new CustomShader('GlitchShaderA');
//camHUD.addShader(glitchA);
camGame.addShader(glitchA);
camGame.addShader(redpal);
camGame.addShader(glitchShaderA);
//camHUD.addShader(redpal);
glitchShaderA.glitchAmount = 0.0001;
//jpeg.u_alpha = 0;
//glitchA.dist = 5;
redpal.bitch = 1;
redpal.desaturationAmount = 0;
redpal.amplitude = 0;
redpal.frequency = 1;
redpal.distortionTime = 1;
var localTime:Float = 0;
var start;
function onSongStart(){
    start = true;
}
function part2() {
    
}
function stepHit() {
    switch(curStep){
        case 228:
            FlxTween.tween(redpal, {bitch: 0.2}, 40);
        case 384:
            FlxTween.tween(redpal, {desaturationAmount: 1}, 10);
        case 1152, 1536, 1920, 2912:
            redpal.bitch = 0.3;
            redpal.desaturationAmount = 0;
        case 1280, 1664, 2432, 3168: 
            FlxTween.tween(redpal, {bitch: 1}, 1);
            FlxTween.tween(redpal, {desaturationAmount: 1}, 1);
        case 2416:
            FlxTween.tween(glitchShaderA, {glitchAmount: 100}, 5);
        case 2640:
            FlxTween.tween(glitchShaderA, {glitchAmount: 0.0001}, 1);
        case 2592:
            FlxTween.tween(redpal, {desaturationAmount: 0}, 0.01);
            FlxTween.tween(redpal, {bitch: 1}, 0.01);
        case 2624:
            FlxTween.tween(redpal, {desaturationAmount: 1}, 1);
            FlxTween.tween(redpal, {bitch: 0.3}, 1);
    }
}
function update(elapsed:Float) {
    //if (start){
    //    glitchA.am = CoolUtil.fpsLerp(glitchA.am, 1.5, 0.05);
    //}
    glitchShaderA.iTime = localTime;
	localTime += elapsed;
    glitchA.iTime = localTime;
    
    //glitchA.dist = 0.5 - (health/3.0);
}