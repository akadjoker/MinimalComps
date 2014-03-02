package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import minimalcomps.CheckBox;
import minimalcomps.ColorChooser;
import minimalcomps.HSlider;
import minimalcomps.HUISlider;
import minimalcomps.IndicatorLight;
import minimalcomps.Knob;
import minimalcomps.Meter;
import minimalcomps.ProgressBar;
import minimalcomps.RadioButton;
import minimalcomps.RotarySelector;
import minimalcomps.VBox;
import minimalcomps.HBox;
import minimalcomps.VSlider;
import minimalcomps.VUISlider;
import minimalcomps.WheelMenu;
import minimalcomps.Window;


import minimalcomps.Component;
import minimalcomps.Label;
import minimalcomps.PushButton;
import minimalcomps.Panel;
import minimalcomps.Text;
import minimalcomps.InputText;
/**
 * ...
 * @author djoker
 */

class Main extends Sprite 
{
	var inited:Bool;
	
	var container:Sprite;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		
		
		new Knob( this , 10 , 400 , "Knob" );	
		new InputText( this , 100 , 400 , "InputText" );	
		

		
	    new Text( this , 0 , 0 , "Text" );
		
		new HUISlider( this , 220 , 0 , "Horizontal Slider" );
		new VUISlider( this , 220 , 20 , "Vertical Slider" );
		
		/*
		var vbox = new VBox( this , 0 , 120 );
		new RadioButton( vbox , 0 , 0 , "Radio 1" , false );
		new RadioButton( vbox , 0 , 0 , "Radio 2" , false );
		new RadioButton( vbox , 0 , 0 , "Radio 3" , true );
		*/
	
		var wheel = new WheelMenu( this , 6 );
		new PushButton( this , 100 , 120 , "Show WheelMenu" , function(e) {
			wheel.show();
		} );
		

		
		var hbox = new HBox( this , 0 , 200 );
		
		new CheckBox( hbox , 0 , 0 , "Check 1" );
	

		
		
		var win = new Window( this ,450,10,"meter");
		
		win.hasMinimizeButton = true;
		win.minimized = true;
		win.setSize( 300 , 200 );

		new Meter( win.content , 0 , 40 ).value = .9;
		new RadioButton( this , 150 , 300 , "Radio 1" , false );
		new RadioButton( this , 150 , 315 , "Radio 2" , false );
		new RadioButton( this , 150 , 330 , "Radio 3" , true );
		
		new CheckBox( this , 250 , 300 , "Check 1" );
		new CheckBox( this , 250 , 315 , "Check 2" );
		new CheckBox( this , 250 , 330 , "Check 3" );
		
		
		var light = new IndicatorLight( this,400,200 );
		var col : ColorChooser = null;
		col = new ColorChooser( this , 450 , 200 , 0xffffff , function(e) {
			light.color = col.value;
			light.flash();
		} );
		col.usePopup = true;
		new ProgressBar( this,300,400 ).value = 1;
	
		
	
	}

	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
