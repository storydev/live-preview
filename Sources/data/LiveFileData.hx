package data;

typedef LiveFileData =
{
	var sourceFile:String;
	var modified:Date;
	@:optional var requiredFiles:Array<String>;
}