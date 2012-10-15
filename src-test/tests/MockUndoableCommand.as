/*
 * Copyright (c) 2012 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */
package tests
{

	import org.robotlegs.utilities.undoablecommand.UndoableCommand;

	/**
	 * @private
	 */
	public class MockUndoableCommand extends UndoableCommand
	{

		public static const DONE : String = "done";

		public static const UNDONE : String = "undone";

		/**
		 * @private
		 */
		private var _state : String;


		public function MockUndoableCommand()
		{
			_state = null;
		}


		override public function execute() : void
		{
			super.execute();
			_state = DONE;
		}


		override public function unexecute() : void
		{
			super.unexecute();
			_state = UNDONE;
		}


		/**
		 * get the current state of the command
		 * 
		 * @return String the current state: null, DONE or UNDONE 
		 */
		public function get state() : String
		{
			return _state;
		}
	}
}