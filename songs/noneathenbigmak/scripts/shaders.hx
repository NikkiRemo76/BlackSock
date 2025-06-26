/*glitchA = new CustomShader('glitchA');
//camHUD.addShader(glitchA);
camGame.addShader(glitchA);

//glitchA.dist = 5;

var localTime:Float = 0;
var start;
function onSongStart(){
    start = true;
}
function update(elapsed:Float) {
    //if (start){
    //    glitchA.am = CoolUtil.fpsLerp(glitchA.am, 1.5, 0.05);
    //}
	localTime += elapsed;
    glitchA.iTime = localTime;
    glitchA.dist = 0.5 - (health/3.0);
}*/