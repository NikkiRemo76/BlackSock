importScript("data/scripts/resizing");
ratioThing(360, 640, false);
canPause = false;
function destroy(){
    ratioThing(1280, 720, true);
    canPause = true;
}