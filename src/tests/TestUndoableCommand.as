/*
 * Copyright (c) 2012 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */
package tests
{

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;
	import org.robotlegs.utilities.undoablecommand.CommandHistory;

	/**
	 * @private
	 */
	public class TestUndoableCommand
	{

		private var command : MockUndoableCommand;

		private var history : CommandHistory;

		[Before]
		public function runBeforeEachTest() : void
		{
			command = new MockUndoableCommand();
			history = new CommandHistory();
		}


		[After]
		public function runAfterEachTest() : void
		{
			command = null;
			history = null;
		}


		[Test]
		public function testConstructedState() : void
		{
			assertNull("constructed state fail", command.state);
		}


		[Test]
		public function testUndoneState() : void
		{
			command.unexecute();
			assertEquals("undone state fail", MockUndoableCommand.UNDONE, command.state);
		}


		[Test]
		public function testDoneState() : void
		{
			command.execute();
			assertEquals("done state fail", MockUndoableCommand.DONE, command.state);
		}
		
		[Test]
		public function testAutoAdd() : void
		{
			command.history = history;
			command.execute();
			assertEquals("num undos fail after autoAdd", 1, history.undoLevels);
			assertEquals("num redos fail after autoAdd", 0, history.redoLevels);
			assertEquals("done state fail", MockUndoableCommand.DONE, command.state);
		}
		
		
		[Test]
		public function testAutoAddUndo() : void
		{
			command.history = history;
			command.execute();
			history.undo();
			assertEquals("num undos fail after autoAdd, undo", 0, history.undoLevels);
			assertEquals("num redos fail after autoAdd, undo", 1, history.redoLevels);
			assertEquals("done state fail", MockUndoableCommand.UNDONE, command.state);
		}
		
		
		[Test]
		public function testAutoAddUndoRedo() : void
		{
			command.history = history;
			command.execute();
			history.undo();
			history.redo();
			assertEquals("num undos fail after autoAdd, undo, redo", 1, history.undoLevels);
			assertEquals("num redos fail after autoAdd, undo, redo", 0, history.redoLevels);
			assertEquals("done state fail", MockUndoableCommand.DONE, command.state);
		}
	}
}