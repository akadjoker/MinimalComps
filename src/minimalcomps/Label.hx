/**
 * Label.as
 * Keith Peters
 * version 0.97
 * 
 * A Label component for displaying a single line of text.
 * 
 * Copyright (c) 2009 Keith Peters
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
 /*
  * 
  * modify and fix to haxe 3 by
  * 
  * Luis Santos AKA DJOKER
  * http://code-haxe.co.nf/index.html
  * */
 
package minimalcomps;

import flash.display.DisplayObjectContainer;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

class Label extends Component {
	
	public var autoSize(get_autoSize, set_autoSize) : Bool;
	public var text(get_text, set_text) : String;
	var _autoSize:Bool;
	var _text:String;
	var _tf:TextField;
	
	/**
	 * Constructor
	 * @param parent The parent DisplayObjectContainer on which to add this Label.
	 * @param xpos The x position to place this component.
	 * @param ypos The y position to place this component.
	 * @param text The string to use as the initial text in this component.
	 */
	public function new(?parent:Dynamic = null, ?xpos:Float = 0, ?ypos:Float =  0, ?text:String = "") {
		_autoSize = true;
		_text = "";
		_text = text;
		super(parent, xpos, ypos);
	}
	
	/**
	 * Initializes the component.
	 */
	override function init() {
		super.init();
		mouseEnabled = false;
		mouseChildren = false;
	}
	
	/**
	 * Creates and adds the child display objects of this component.
	 */
	override function addChildren() {
		_height = 18;
		_tf = new TextField();
		_tf.height = _height;
		//_tf.textColor = Style.LABEL_TEXT;
		//_tf.embedFonts = true;
		_tf.selectable = false;
		_tf.mouseEnabled = false;
		//_tf.defaultTextFormat = new TextFormat("pf_ronda_seven_bold.ttf", 8, Style.LABEL_TEXT);
		_tf.defaultTextFormat = new TextFormat("arial", 12, Style.LABEL_TEXT);
		_tf.text = _text;			
		addChild(_tf);
		draw();
	}
	
	
	
	
	///////////////////////////////////
	// public methods
	///////////////////////////////////
	
	/**
	 * Draws the visual ui of the component.
	 */
	public override function draw() {
		super.draw();
		_tf.text = _text;
		if(_autoSize) {
			_tf.autoSize = TextFieldAutoSize.LEFT;
			_width = Std.int( _tf.width );
		} else {
			_tf.autoSize = TextFieldAutoSize.NONE;
			_tf.width = _width;
		}
		_tf.height = 18.;
		_height = 18;
	}
	
	///////////////////////////////////
	// event handlers
	///////////////////////////////////
	
	///////////////////////////////////
	// getter/setters
	///////////////////////////////////
	
	/**
	 * Gets / sets the text of this Label.
	 */
	public function set_text(t:String):String {
		_text = t;
		invalidate();
		return t;
	}
	public function get_text():String {
		return _text;
	}
	
	/**
	 * Gets / sets whether or not this Label will autosize.
	 */
	public function set_autoSize(b:Bool):Bool {
		_autoSize = b;
		return b;
	}
	public function get_autoSize():Bool {
		return _autoSize;
	}
}
