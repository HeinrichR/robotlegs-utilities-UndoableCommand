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

		private var _data : Object;


		public function HistoryEvent(type : String, data : Object = null)
		{
			super(type);
		}


		public function get data() : Object
		{
			return _data;
		}


		override public function clone() : Event
		{
			return new HistoryEvent(type, data);
		}
	}
}
