package tests {
	import org.robotlegs.utilities.undoablecommand.ManagedUndoableCommand;
	
	
	/**
	 * @private
	 */
	public class MockManagedUndoableCommand extends ManagedUndoableCommand {
		
		/**
		 * Reference to some array to be tested on.
		 */
		public var testArray:Array;
		
		/**
		 * Cause change to the array
		 */
		override protected function doExecute():Boolean {
			super.doExecute();
			this.testArray.push(new Object());
			return super.doExecute();
		}
		
		/**
		 * Undo the change on the array
		 */
		override protected function undoExecute():Boolean {
			super.undoExecute();
			// pop() isn't the best undo is it
			// will do for now
			this.testArray.pop();
			return super.undoExecute();
		}
	}
}