function postCreate()
    FlxG.state.forEachOfType(FlxText, text -> text.font = Paths.font("Slovic_Demo_VarGX.ttf"));