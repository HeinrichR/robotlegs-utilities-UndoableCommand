package org.robotlegs.utilities.undoablecommand.event
{

	import flash.events.Event;

	/**
	 * HistoryEvent
	 * 
	 */
	public class HistoryEvent extends Event
	{
		public static const CLEAR : String = "onHistoryClear";

		public static const UNDO : String = "onHistoryUndo";

		public static const REDO : String = "onHistoryRedo";

		public static const CHANGED : String = "onHistoryChanged";

		private var _levels : uint;

		public function HistoryEvent(type : String, levels : uint = 1)
		{
			super(type);
			_levels = levels;
		}


		public function get levels() : uint
		{
			return _levels;
		}


		override public function clone() : Event
		{
			return new HistoryEvent(type, _levels);
		}
	}
}
