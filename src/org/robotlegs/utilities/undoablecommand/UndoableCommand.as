/*
 * Copyright (c) 2012 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */
package org.robotlegs.utilities.undoablecommand
{

	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.undoablecommand.interfaces.IUndoableCommand;
	import org.robotlegs.utilities.undoablecommand.interfaces.ICommandHistory;

	/**
	 * This command handles adding itself to the provided/injected CommandHistory.
	 * 
	 * Override methods execute and unexecute:
	 * execute should contain the code you want to execute when the command is fired;
	 * unexecute should contain whatever code is needed to manually undo the actions performed by execute.
	 * After performing execute functionality, call super.execute() to have command add itself to the injected ICommandHistory implementation.
	 * Exit execute method without calling super.execute() to prevent command from being added to the history.
	 * 
	 * All functions assume the CommandHistory dependency has been provided as the public property 'history'.
	 */
	public class UndoableCommand extends Command implements IUndoableCommand
	{

		/**
		 * Reference to the ICommandHistory being used by this Command
		 */
		[Inject]
		public var history : ICommandHistory;


		/**
		 * subclasses should override execute and call super.execute() to be added to the undo history
		 */
		override public function execute() : void
		{
			if ( history )
			{
				history.add(this);
			}
		}


		public function unexecute() : void
		{
			// implement in subclasses
		}
	}
}