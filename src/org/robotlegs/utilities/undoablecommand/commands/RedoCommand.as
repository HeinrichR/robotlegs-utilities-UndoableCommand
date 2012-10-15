/*
 * Copyright (c) 2012 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */
package org.robotlegs.utilities.undoablecommand.commands
{

	import org.robotlegs.utilities.undoablecommand.event.HistoryEvent;
	import org.robotlegs.utilities.undoablecommand.interfaces.ICommandHistory;

	/**
	 * Map this command to the HistoryEvent.REDO event to trigger redo action(s).
	 * Provided for convenience.
	 * 
	 * Pass number of redo levels as an integer data argument to the HistoryEvent to perfom multiple redos
	 */
	public class RedoCommand
	{

		[Inject]
		public var commandHistory : ICommandHistory;

		[Inject]
		public var event : HistoryEvent;


		public function RedoCommand()
		{
		}


		/**
		 * execute redo
		 */
		public function execute() : void
		{
			var levels : int = int(event.data);
			if ( levels < 1 ) levels = 1;
			commandHistory.redo(levels);
		}
	}
}