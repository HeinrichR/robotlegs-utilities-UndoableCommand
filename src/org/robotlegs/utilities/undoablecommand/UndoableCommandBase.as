package org.robotlegs.utilities.undoablecommand
{

	import org.robotlegs.utilities.undoablecommand.interfaces.IUndoableCommand;

	import flash.events.IEventDispatcher;
		
	public class UndoableCommandBase implements IUndoableCommand
	{
		/**
		 * Keeps track of whether this command has been executed,
		 * to prevent undoing commands that have not been yet been executed.
		 */
		protected var hasExecuted:Boolean;
		
		/**
		 * @private
		 * Reference to the function to execute in the execute() function
		 */
		private var doFunction:Function;
		
		/**
		 * @private
		 * Reference to the undo function to execute in the undo() function 
		 */
		private var undoFunction:Function;
		
		private var _eventDispatcher:IEventDispatcher;
		
		
		/**
		 * Creates a new UndoableCommand
		 * @param doFunction the function to execute
		 * @param undoFunction execute this function to undo the operations of doFunction
		 * @param autoExecute automatically executes this command on creation. Be careful when setting this false
		 */
		public function UndoableCommandBase(doFunction:Function = null, undoFunction:Function = null) {
			// set function defaults
			if (doFunction is Function) {
				this.doFunction = doFunction;
			} else {
				this.doFunction = doExecute;
			}
			
			if (undoFunction is Function) {
				this.undoFunction = undoFunction;
			} else {
				this.undoFunction = undoExecute;
			}
		}
		
		/**
		 * Executes the command.
		 * If we passed in an execute function to the constructor,
		 * execute passed-in function, otherwise execute overriden
		 * doExecute function.
		 * Will not execute more than once without first undoing
		 */
		public final function execute():void {
			if (!hasExecuted) {			
				doFunction();
				hasExecuted = true;
				eventDispatcher.dispatchEvent(new CommandEvent(CommandEvent.EXECUTE_COMPLETE, this));
			}
		}
		
		/**
		 * Executes the undo function.
		 * If we passed in an undo function to the constructor,
		 * execute passed-in undo function, otherwise execute overriden
		 * undoExecute function.
		 * Will not undo if function has not executed.
		 */
		public final function undo():void {
			if (hasExecuted) {
				undoFunction();	
				hasExecuted = false;
				eventDispatcher.dispatchEvent(new CommandEvent(CommandEvent.UNDO_EXECUTE_COMPLETE, this));
			}
		}	
		
		/**
		 * Subclasses MUST override this function with the body of their command.
		 */
		protected function doExecute():void {
			
		}
		
		/**
		 * Subclasses must override this function. This function should undo whatever the doExecute command did. 
		 */
		protected function undoExecute():void {
			
		}
		
		/**
		 * Event bus to dispatch events on.
		 */
		[Inject]
		public function get eventDispatcher():IEventDispatcher {
			return _eventDispatcher;
		}

		public function set eventDispatcher(value:IEventDispatcher):void {
			_eventDispatcher = value;
		}

		/**
		 * Subclasses may override
		 */
		public function release() : void {
		}
	}
}