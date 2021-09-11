package;

import twinspire.events.Event;
import twinspire.events.EventType;

import kha.graphics2.Graphics;

import hscript.Parser;
import hscript.Interp;

import data.LiveFileData;

import haxe.Json;

#if (sys || hxnodejs)
import sys.io.File;
import sys.FileStat;
import sys.FileSystem;
#end

@:build(twinspire.macros.StaticBuilder.build())
class Game
{

	@:local
	var mouseX:Int;
	var mouseY:Int;
	var mouseDown:Bool;
	var mouseReleased:Bool;

	var fileData:LiveFileData;

	var script:Dynamic;

	var parser:Parser;
	var interp:Interp;

	var g2:Graphics;

	@:global
	function init()
	{
		fileData = {
			sourceFile: "",
			modified: Date.now()
		};

		parser = new Parser();
		parser.allowTypes = true;
		parser.allowJSON = true;
		
		interp = new Interp();

		#if sys
		if (FileSystem.exists("live.dat"))
		{
			var content = File.getContent("live.dat");
			fileData = Json.parse(content);
		}

		if (fileData.requiredFiles != null)
		{
			if (fileData.requiredFiles.length > 0)
			{
				var code = "";
				for (i in 0...fileData.requiredFiles.length)
				{
					var content = File.getContent(fileData.requiredFiles[i]);
					code += content;
				}

				var parsed = parser.parseString(code);
				interp.execute(parsed);
			}
		}
		#end
	}

	function handleEvent(e:Event)
	{
		if (e.type == EVENT_MOUSE_MOVE)
		{
			mouseX = e.mouseX;
			mouseY = e.mouseY;
		}
		else if (e.type == EVENT_MOUSE_UP)
		{
			mouseDown = false;
			mouseReleased = true;
		}
		else if (e.type == EVENT_MOUSE_DOWN)
		{
			mouseDown = true;
		}
	}

	function render(g2:Graphics)
	{
		Game.g2 = g2;

		#if (sys || hxnodejs)
		if (FileSystem.exists("live.dat"))
		{
			var content = File.getContent("live.dat");
			fileData = Json.parse(content);
		}

		if (FileSystem.exists(fileData.sourceFile))
		{
			var lastModified = FileSystem.stat(fileData.sourceFile).mtime;
			if (compareDate(fileData.modified, lastModified) != 0)
			{
				fileData.modified = lastModified;
				var content = File.getContent(fileData.sourceFile);
				script = parser.parseString(content);
			}
		}
		#end

		if (script != null)
			interp.execute(script);

		mouseReleased = false;
	}

	function compareDate(d1:Date, d2:Date):Int
	{
		var result = -1;
		if (d1.getTime() == d2.getTime())
			result = 0;
		else if (d1.getTime() > d2.getTime())
			result = 1;
		
		return result;
	}

}