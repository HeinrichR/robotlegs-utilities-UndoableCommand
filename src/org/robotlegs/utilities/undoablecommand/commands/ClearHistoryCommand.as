package org.robotlegs.utilities.undoablecommand.commands
{

	import org.robotlegs.utilities.undoablecommand.interfaces.ICommandHistory;

	/**
	 * Map this command to the HistoryEvent.STEP_BACKWARD event to trigger an undo action.
	 * Provided for convenience.
	 */
	public class ClearHistoryCommand
	{

		[Inject]
		public var commandHistory : ICommandHistory;


		public function execute() : void
		{
			commandHistory.clear();
		}
	}
}