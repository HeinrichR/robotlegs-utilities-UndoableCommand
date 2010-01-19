package tests
{
	import flash.events.EventDispatcher;
	
	import org.robotlegs.utilities.undoablecommand.UndoableCommand;
	import org.robotlegs.utilities.undoablecommand.interfaces.IUndoableCommand;
	
	/**
	 * @private
	 */
	public class MockUndoableCommand extends UndoableCommand implements IUndoableCommand
	{
		public var testArray:Array = new Array();;
		
		public function MockUndoableCommand() {
			eventDispatcher = new EventDispatcher();
			super();
		}
		
		/**
		 * Cause damage to the array
		 */
		override protected function doExecute():Boolean {
			
			trace("Do ta:" + testArray);
			testArray.push(new Object());
			return super.doExecute();
		}
		
		/**
		 * Undo the damage on the array
		 */
		override protected function undoExecute():Boolean {
			trace("Undo ta:" + testArray);
			testArray.pop();
			return super.undoExecute();
		}
	}
}