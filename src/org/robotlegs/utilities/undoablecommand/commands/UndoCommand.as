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
	 * Map this command to the HistoryEvent.UNDO event to trigger undo action(s).
	 * Provided for convenience.
	 * 
	 * Pass number of undo levels as an integer data argument to the HistoryEvent to perfom multiple undos
	 */
	public class UndoCommand
	{

		[Inject]
		public var commandHistory : ICommandHistory;

		[Inject]
		public var event : HistoryEvent;


		public function UndoCommand()
		{
		}


		/**
		 * execute undo 
		 */
		public function execute() : void
		{
			var levels : int = int(event.data);
			if ( levels < 1 ) levels = 1;
			commandHistory.undo(levels);
		}
	}
}