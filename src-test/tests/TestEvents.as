/*
 * Copyright (c) 2012 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */
package tests
{

	import org.flexunit.asserts.assertEquals;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.robotlegs.utilities.undoablecommand.event.HistoryEvent;
	import org.robotlegs.utilities.undoablecommand.interfaces.ICommandHistory;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	/**
	 * @private
	 */
	public class TestEvents
	{
		private var history : ICommandHistory;

		private var contextView : Sprite;

		private var context : MockHistoryContext;

		private var eventDispatcher : IEventDispatcher;

		[Before]
		public function runBeforeEachTest() : void
		{
			contextView = new Sprite();

			UIImpersonator.addChild(contextView);

			context = new MockHistoryContext(contextView);

			eventDispatcher = context.eventDispatcher;

			history = context.history;
		}


		[After]
		public function runAfterEachTest() : void
		{
			context.shutdown();
			context = null;

			history = null;

			contextView = null;
		}


		[Test]
		public function testExecCommand() : void
		{
			eventDispatcher.dispatchEvent(new Event(MockHistoryContext.EXEC_UNDOABLE_COMMAND));

			assertEquals("test exec command fail, num undo leves fail", 1, history.undoLevels);

			assertEquals("test exec command fail, num redo leves fail", 0, history.redoLevels);
		}


		[Test]
		public function testExecTwoCommands() : void
		{
			eventDispatcher.dispatchEvent(new Event(MockHistoryContext.EXEC_UNDOABLE_COMMAND));

			eventDispatcher.dispatchEvent(new Event(MockHistoryContext.EXEC_UNDOABLE_COMMAND));

			assertEquals("test exec two commands, num undo levels fail", 2, history.undoLevels);
		}


		[Test]
		public function testFireUndo() : void
		{
			eventDispatcher.dispatchEvent(new Event(MockHistoryContext.EXEC_UNDOABLE_COMMAND));

			eventDispatcher.dispatchEvent(new HistoryEvent(HistoryEvent.UNDO));

			assertEquals("test fire undo, num undo levels fail", 0, history.undoLevels);
		}


		[Test]
		public function testFireUndoTwice() : void
		{
			eventDispatcher.dispatchEvent(new Event(MockHistoryContext.EXEC_UNDOABLE_COMMAND));

			eventDispatcher.dispatchEvent(new Event(MockHistoryContext.EXEC_UNDOABLE_COMMAND));

			eventDispatcher.dispatchEvent(new HistoryEvent(HistoryEvent.UNDO));

			eventDispatcher.dispatchEvent(new HistoryEvent(HistoryEvent.UNDO));

			assertEquals("test fire undo twice, num undo levels fail", 0, history.undoLevels);
		}


		[Test]
		public function testFireUndoTwoLevels() : void
		{
			eventDispatcher.dispatchEvent(new Event(MockHistoryContext.EXEC_UNDOABLE_COMMAND));

			eventDispatcher.dispatchEvent(new Event(MockHistoryContext.EXEC_UNDOABLE_COMMAND));

			eventDispatcher.dispatchEvent(new HistoryEvent(HistoryEvent.UNDO, 2));

			assertEquals("test fire undo two levels, num undo levels fail", 0, history.undoLevels);
		}


		[Test]
		public function testFireRedo() : void
		{
			eventDispatcher.dispatchEvent(new Event(MockHistoryContext.EXEC_UNDOABLE_COMMAND));

			eventDispatcher.dispatchEvent(new HistoryEvent(HistoryEvent.UNDO));

			eventDispatcher.dispatchEvent(new HistoryEvent(HistoryEvent.REDO));

			assertEquals("test fire redo, num levels fail", 1, history.undoLevels);
		}


		[Test]
		public function testFireRedoTwice() : void
		{
			eventDispatcher.dispatchEvent(new Event(MockHistoryContext.EXEC_UNDOABLE_COMMAND));

			eventDispatcher.dispatchEvent(new Event(MockHistoryContext.EXEC_UNDOABLE_COMMAND));

			eventDispatcher.dispatchEvent(new HistoryEvent(HistoryEvent.UNDO));

			eventDispatcher.dispatchEvent(new HistoryEvent(HistoryEvent.UNDO));

			eventDispatcher.dispatchEvent(new HistoryEvent(HistoryEvent.REDO));

			eventDispatcher.dispatchEvent(new HistoryEvent(HistoryEvent.REDO));

			assertEquals("test fire redo twice, undo levels fail", 2, history.undoLevels);

			assertEquals("test fire redo twice, redo levels fail", 0, history.redoLevels);
		}


		[Test]
		public function testFireRedoTwoLevels() : void
		{
			eventDispatcher.dispatchEvent(new Event(MockHistoryContext.EXEC_UNDOABLE_COMMAND));

			eventDispatcher.dispatchEvent(new Event(MockHistoryContext.EXEC_UNDOABLE_COMMAND));

			eventDispatcher.dispatchEvent(new HistoryEvent(HistoryEvent.UNDO));

			eventDispatcher.dispatchEvent(new HistoryEvent(HistoryEvent.UNDO));

			eventDispatcher.dispatchEvent(new HistoryEvent(HistoryEvent.REDO, 2));

			assertEquals("test fire redo twice, undo levels fail", 2, history.undoLevels);

			assertEquals("test fire redo twice, redo levels fail", 0, history.redoLevels);
		}
		
		
		[Test]
		public function testFireClear() : void
		{
			eventDispatcher.dispatchEvent(new Event(MockHistoryContext.EXEC_UNDOABLE_COMMAND));

			eventDispatcher.dispatchEvent(new Event(MockHistoryContext.EXEC_UNDOABLE_COMMAND));

			eventDispatcher.dispatchEvent(new HistoryEvent(HistoryEvent.UNDO));
			
			eventDispatcher.dispatchEvent(new HistoryEvent(HistoryEvent.CLEAR));

			assertEquals("test fire clear, undo levels fail", 0, history.undoLevels);

			assertEquals("test fire clear, redo levels fail", 0, history.redoLevels);
		}
	}
}
