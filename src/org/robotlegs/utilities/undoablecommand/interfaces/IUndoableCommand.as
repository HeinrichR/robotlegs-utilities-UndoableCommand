package org.robotlegs.utilities.undoablecommand.interfaces
{
	/**
	 * @author derek
	 */
	public interface IUndoableCommand
	{

		function execute() : void;


		function unexecute() : void;
	}
}
