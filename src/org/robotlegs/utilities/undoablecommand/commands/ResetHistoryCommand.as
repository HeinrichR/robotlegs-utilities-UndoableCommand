package org.robotlegs.utilities.undoablecommand.commands
{
	import org.robotlegs.utilities.undoablecommand.CommandHistory;

	
	/**
	 * Map this command to the HistoryEvent.STEP_BACKWARD event to trigger an undo action.
	 * Provided for convenience.
	 */
	public class ResetHistoryCommand
	{
		[Inject]
		public var commandHistory:CommandHistory;
		
		/**
		 * Reset history and release any previously added commands
		 */
		public function execute():void {
			commandHistory.reset();
		}
	}
}