package org.robotlegs.utilities.undoablecommand.interfaces
{
	import flash.events.IEventDispatcher;

	public interface IUndoableCommand {
		
		/**
		 * Perform an action
		 */
		function execute():void;
		
		/**
		 * Reverse the performed action
		 */
		function undo():void;
		
		/**
		 * Called when the command is permanently removed from the history stack
		 */
		function release():void;
		 
		/**
		 * Fire events when you execute or undo
		 */
		function get eventDispatcher():IEventDispatcher;
		function set eventDispatcher(value:IEventDispatcher):void;
	}
}