package org.robotlegs.utilities.undoablecommand.interfaces
{
	import flash.events.IEventDispatcher;
	/**
	 * @author derek
	 */
	public interface ICommandHistory
	{
		function reset():void;
		
		function get canStepForward():Boolean;
		
		function get canStepBackward():Boolean;
		
		function stepForward():uint;
		
		function stepBackward():uint;
		
		function rewind(numTimes:uint = 0):uint;
		
		function fastForward(numTimes:uint = 0):uint;
		
		function get numberOfHistoryItems():uint;
		
		function push(command:IUndoableCommand):uint;
		
		function get currentCommand():IUndoableCommand;

	}
}
