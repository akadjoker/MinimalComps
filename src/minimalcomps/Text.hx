/**
 * Label.as
 * Keith Peters
 * version 0.97
 * 
 * A Text component for displaying multiple lines of text.
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
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;

class Text extends Component {
	
	public var editable(get_editable, set_editable) : Bool;
	public var text(get_text, set_text) : String;
	
	var _tf:TextField;
	var _text:String ;
	var _editable:Bool;
	var _panel:Panel;
	
	/**
	 * Constructor
	 * @param parent The parent DisplayObjectContainer on which to add this Label.
	 * @param xpos The x position to place this component.
	 * @param ypos The y position to place this component.
	 * @param text The initial text to display in this component.
	 */
	public function new(?parent:Dynamic = null, ?xpos:Float = 0, ?ypos:Float =  0, ?text:String = "") {
		_text = "";
		_editable = true;
		_text = text;
		super(parent, xpos, ypos);
		setSize(200, 100);
	}
	
	/**
	 * Initializes the component.
	 */
	override function init() {
		super.init();
	}
	
	/**
	 * Creates and adds the child display objects of this component.
	 */
	override function addChildren() {
		_panel = new Panel(this);
		_panel.color = 0xffffff;
		
		_tf = new TextField();
		_tf.x = 2;
		_tf.y = 2;
		_tf.height = _height;
		//_tf.textColor = Style.INPUT_TEXT;
		//_tf.embedFonts = true;
		_tf.multiline = true;
		_tf.wordWrap = true;
		_tf.selectable = true;
		_tf.type = TextFieldType.INPUT;
		//_tf.defaultTextFormat = new TextFormat("PFRondaSeven", 8, Style.LABEL_TEXT);
		_tf.defaultTextFormat = new TextFormat("arial", 12, Style.LABEL_TEXT);
		_tf.addEventListener(Event.CHANGE, onChange);			
		addChild(_tf);
	}
	
	
	
	
	///////////////////////////////////
	// public methods
	///////////////////////////////////
	
	/**
	 * Draws the visual ui of the component.
	 */
	public override function draw() {
		super.draw();
		
		_panel.setSize(_width, _height);
		
		_tf.width = _width - 4;
		_tf.height = _height - 4;
		_tf.text = _text;
		if(_editable) {
			_tf.mouseEnabled = true;
			_tf.selectable = true;
			_tf.type = TextFieldType.INPUT;
		} else {
			_tf.mouseEnabled = false;
			_tf.selectable = false;
			_tf.type = TextFieldType.DYNAMIC;
		}
	}
	
	
	
	
	///////////////////////////////////
	// event handlers
	///////////////////////////////////
	
	function onChange(event:Event) {
		_text = _tf.text;
		dispatchEvent(event);
	}
	
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
	 * Gets / sets whether or not this text component will be editable.
	 */
	public function set_editable(b:Bool):Bool {
		_editable = b;
		invalidate();
		return b;
	}
	public function get_editable():Bool {
		return _editable;
	}
}