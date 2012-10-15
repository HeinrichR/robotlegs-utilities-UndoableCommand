package org.robotlegs.utilities.undoablecommand.interfaces
{
	/**
	 * ICommandHistory interface
	 */
	public interface ICommandHistory
	{

		function clear() : void;


		function undo(levels : int = 1) : void;


		function redo(levels : int = 1) : void;


		function add(command : IUndoableCommand) : void;


		function isAdded( command : IUndoableCommand ):Boolean;
		
		
		function get canUndo() : Boolean;


		function get canRedo() : Boolean;


		function get undoLevels() : int;


		function get redoLevels() : int;
		
	}
}
