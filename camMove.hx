//the most based camera movement script ever... -stilic

var add = 34;
var offsets = [];

function postCreate() {
	//p is useless but who cares lol -stilic
	for (p in players)
		offsets.push([FlxPoint.get()]);
}

function onPlayerHit(event) {
	if (!event.animCancelled) {
		var id = players.indexOf(event.note.strumLine);
		var arr = offsets[id];
		if (arr == null) {
			arr = [FlxPoint.get()];
			offsets[id] = arr;
		}
		arr[0].set(event.direction == 0 ? -add : (event.direction == 3 ? add : 0), event.direction == 1 ? add : (event.direction == 2 ? -add : 0));
		if (arr[1] != null)
			arr[1].cancel();
		arr[1] = FlxTween.tween(arr[0], {x: 0, y: 0}, 0.75, { ease: FlxEase.cubeOut });
	}
}

function onPlayerMiss(event) {
	onPlayerHit(event);
}

function onDadHit(event) {
	onPlayerHit(event);
}

function onCameraMove(event) {
	var offset = offsets[players.indexOf(event.strumLine)][0];
	event.position.x += offset.x;
	event.position.y += offset.y;
}

function destroy() {
	for (o in offsets)
		o[0].put();
}
