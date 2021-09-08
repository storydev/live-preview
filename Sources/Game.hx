package;

import twinspire.events.Event;
import twinspire.events.EventType;

import kha.graphics2.Graphics;

@:build(twinspire.macros.StaticBuilder.build())
class Game
{

	@:local
	var mouseX:Int;
	var mouseY:Int;
	var mouseDown:Bool;
	var mouseReleased:Bool;

	@:global
	function init()
	{

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


		mouseReleased = false;
	}

}