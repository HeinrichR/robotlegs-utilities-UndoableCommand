package tests
{

	import org.robotlegs.base.CommandMap;
	import org.robotlegs.mvcs.Context;
	import org.robotlegs.utilities.undoablecommand.CommandHistory;
	import org.robotlegs.utilities.undoablecommand.commands.ClearHistoryCommand;
	import org.robotlegs.utilities.undoablecommand.commands.RedoCommand;
	import org.robotlegs.utilities.undoablecommand.commands.UndoCommand;
	import org.robotlegs.utilities.undoablecommand.event.HistoryEvent;
	import org.robotlegs.utilities.undoablecommand.interfaces.ICommandHistory;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author derek
	 */
	public class MockHistoryContext extends Context
	{
		public static const EXEC_UNDOABLE_COMMAND : String = "execUndoableCommand";

		[Inject]
		public var history : ICommandHistory;

		public function MockHistoryContext(contextView : DisplayObjectContainer = null, autoStartup : Boolean = true)
		{
			super(contextView, autoStartup);
		}


		override public function startup() : void
		{
			injector.mapSingleton(CommandHistory);
			injector.mapValue(ICommandHistory, injector.getInstance(CommandHistory));

			injector.injectInto(this);

			commandMap.mapEvent(HistoryEvent.CLEAR, ClearHistoryCommand);
			commandMap.mapEvent(HistoryEvent.UNDO, UndoCommand);
			commandMap.mapEvent(HistoryEvent.REDO, RedoCommand);

			commandMap.mapEvent(EXEC_UNDOABLE_COMMAND, MockUndoableCommand);
		}


		public function get contextCommandMap() : CommandMap
		{
			return commandMap as CommandMap;
		}
	}
}
