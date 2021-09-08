package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Color;

import twinspire.Application;

class Main
{

	public static function main()
	{
		Application.create({ title: "Live Preview", width: 1024, height: 768 }, () -> {
			Game.init();

			System.notifyOnFrames(render);
		});
	}

	static function render(frames:Array<Framebuffer>):Void
	{
		var app = Application.instance;
		var g2 = frames[0].g2;

		while (app.pollEvent())
		{
			Game.handleEvent(app.currentEvent);
		}

		g2.begin(true, Color.Black);

		Game.render(g2);

		g2.end();
	}

}
