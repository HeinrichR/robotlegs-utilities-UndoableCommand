package org.robotlegs.utilities.undoablecommand.event
{

	import flash.events.Event;

	/**
	 * HistoryEvent
	 * 
	 */
	public class HistoryEvent extends Event
	{
		public static const CLEAR : String = "HistoryEvent.CLEAR";

		public static const UNDO : String = "HistoryEvent.UNDO";

		public static const REDO : String = "HistoryEvent.REDO";

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
