/**
 * Component.as
 * Keith Peters
 * version 0.97
 * 
 * Base class for all components
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
 * 
 * 
 * 
 * Components with text make use of the font PF Ronda Seven by Yuusuke Kamiyamane
 * This is a free font obtained from http://www.dafont.com/pf-ronda-seven.font
 */
 
package minimalcomps;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.filters.DropShadowFilter;

class PFRondaSeven extends flash.text.Font {}

class Component implements IEventDispatcher {
	
	public var height(get_height, set_height) : Float;
	public var width(get_width, set_width) : Float;
	public var x(default, set_x) : Float;
	public var y(default, set_y) : Float;
	public var mouseX(get_mouseX,null) : Float;
	public var mouseY(get_mouseY,null) : Float;
	public var mouseEnabled(get_mouseEnabled,null) : Bool;
	public var mouseChildren(get_mouseChildren,null) : Bool;
	public var filters(get_filters,null) : Array<Dynamic>;
	public var useHandCursor(get_useHandCursor,set_useHandCursor) : Bool;
	public var buttonMode(get_buttonMode,set_buttonMode) : Bool;	
	public var stage(get_stage,null) : Stage;
	public var numChildren(get_numChildren,null) : Int;
	public var visible(get_visible,set_visible) : Bool;
	public var graphics(get_graphics,null) : flash.display.Graphics;
	public var parent(default,null) : Dynamic;
	
	// Composition instead of inheritence because of haxe getter/setter handicap
	var _comp : Sprite;
	var _width : Float;
	var _height : Float;
	
	public static var DRAW:String = "draw";

	/**
	 * Constructor
	 * @param parent The parent DisplayObjectContainer on which to add this component.
	 * @param xpos The x position to place this component.
	 * @param ypos The y position to place this component.
	 */
	public function new(?parent:Dynamic = null, ?xpos:Float = 0, ?ypos:Float = 0) {
		_comp = new Sprite();
		_width = 0;
		_height = 0;
		move(xpos, ypos);
		if( parent != null )
			parent.addChild(_comp);
		this.parent = parent;
		init();
	}
		
	/**
	 * Initilizes the component.
	 */
	function init() {
		addChildren();
		invalidate();
	}
	
	/**
	 * Overriden in subclasses to create child display objects.
	 */
	function addChildren() {
		
	}
	
	
	/********** Sprite composition ***************/
	public function addChild( child : Dynamic ) {
		if( Std.is( child , Component) ) child = untyped child._comp;			
		return _comp.addChild( child );
	}
	
	public function removeChild( child : Dynamic ) {
		if( Std.is( child , Component) ) child = untyped child._comp;			
		return _comp.removeChild( child );
	}
	
	public function addEventListener(type : String, listener : Dynamic->Void, useCapture : Bool = false, priority : Int = 0, useWeakReference : Bool = false) : Void {
		_comp.addEventListener( type , listener , useCapture , priority , useWeakReference );
	}
	public function dispatchEvent(event : Event) : Bool {
		return _comp.dispatchEvent( event );
	}
	public function hasEventListener(type : String) : Bool {
		return _comp.hasEventListener( type );
	}
	public function removeEventListener(type : String, listener : Dynamic->Void, useCapture : Bool = false) : Void {
		_comp.removeEventListener( type , listener , useCapture );
	}
	public function willTrigger(type : String) : Bool {
		return _comp.willTrigger( type );
	}
	public function startDrag() {
		_comp.startDrag();
	}
	public function stopDrag() {
		return _comp.stopDrag();
	}
	
	/**
	 * DropShadowFilter factory method, used in many of the components.
	 * @param dist The distance of the shadow.
	 * @param knockout Whether or not to create a knocked out shadow.
	 */
	function getShadow(dist:Float, ?knockout:Bool = false):DropShadowFilter {
		return new DropShadowFilter(dist, 45, Style.DROPSHADOW, 1, dist, dist, .3, 1, knockout);
	}
	
	/**
	 * Marks the component to be redrawn on the next frame.
	 */
	function invalidate() {
		addEventListener(Event.ENTER_FRAME, onInvalidate);
	}
	
	
	
	
	///////////////////////////////////
	// public methods
	///////////////////////////////////
	
	/**
	 * Utility method to set up usual stage align and scaling.
	 */
	public static function initStage(stage:Stage) {
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
	}
	
	/**
	 * Moves the component to the specified position.
	 * @param xpos the x position to move the component
	 * @param ypos the y position to move the component
	 */
	public function move(xpos:Float, ypos:Float) {
		x = Math.round(xpos);
		y = Math.round(ypos);
	}
	
	/**
	 * Sets the size of the component.
	 * @param w The width of the component.
	 * @param h The height of the component.
	 */
	public function setSize(w:Float, h:Float) {
		_width = w;
		_height = h;
		invalidate();
	}
	
	/**
	 * Abstract draw function.
	 */
	public function draw() {
		dispatchEvent(new Event(Component.DRAW));
	}
	
	
	
	
	///////////////////////////////////
	// event handlers
	///////////////////////////////////
	
	/**
	 * Called one frame after invalidate is called.
	 */
	function onInvalidate(event:Event) {
		removeEventListener(Event.ENTER_FRAME, onInvalidate);
		draw();
	}
	
	
	
	
	///////////////////////////////////
	// getter/setters
	///////////////////////////////////
	
	/**
	 * Sets/gets the width of the component.
	 */
	public function set_width(w:Float):Float{
		_width = w;
		invalidate();
		dispatchEvent(new Event(Event.RESIZE));
		return w;
	}
	public function get_width():Float{
		return _width;
	}
	
	/**
	 * Sets/gets the height of the component.
	 */
	public function set_height(h:Float):Float{
		_height = h;
		invalidate();
		dispatchEvent(new Event(Event.RESIZE));
		return h;
	}
	public function get_height():Float{
		return _height;
	}
	
	/**
	 * Overrides the setter for x to always place the component on a whole pixel.
	 */
	public function set_x(value:Float):Float{
		return x = _comp.x = Math.round(value);
	}
	
	/**
	 * Overrides the setter for y to always place the component on a whole pixel.
	 */
	public function set_y(value:Float):Float{
		return y = _comp.y = Math.round(value);
	}
	
	public function get_mouseX():Float{
		return _comp.mouseX;
	}
	
	public function get_mouseY():Float{
		return _comp.mouseY;
	}
	
	public function get_mouseEnabled():Bool{
		return _comp.mouseEnabled;
	}

	public function get_mouseChildren():Bool{
		return _comp.mouseChildren;
	}

	public function get_buttonMode():Bool{
		return _comp.buttonMode;
	}
	public function set_buttonMode(b:Bool):Bool{
		return _comp.buttonMode = b;
	}

	public function get_useHandCursor():Bool{
		return _comp.useHandCursor;
	}
	public function set_useHandCursor(b:Bool):Bool{
		return _comp.useHandCursor = b;
	}
	
	public function get_filters():Array<Dynamic>{
		return _comp.filters;
	}
	
	public function get_stage():Stage{
		return _comp.stage;
	}
	
	public function get_numChildren():Int{
		return _comp.numChildren;
	}
	
	public function getChildAt( n : Int ) : DisplayObject {
		return _comp.getChildAt( n );
	}
	
	public function get_visible() : Bool {
		return _comp.visible;
	}
	public function set_visible( visible : Bool ) : Bool {
		return _comp.visible = visible;
	}
	
	public function get_graphics() : flash.display.Graphics {
		return _comp.graphics;
	}
	
}
