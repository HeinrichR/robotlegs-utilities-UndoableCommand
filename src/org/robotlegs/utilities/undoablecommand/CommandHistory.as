/*
 * Copyright (c) 2012 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */
package org.robotlegs.utilities.undoablecommand
{

	import org.robotlegs.utilities.undoablecommand.event.HistoryEvent;
	import org.robotlegs.mvcs.Actor;
	import org.robotlegs.utilities.undoablecommand.interfaces.ICommandHistory;
	import org.robotlegs.utilities.undoablecommand.interfaces.IUndoableCommand;

	import flash.errors.IllegalOperationError;

	/**
	 * Manages an undo and redo list of IUndoableCommand instances 
	 */
	public class CommandHistory extends Actor implements ICommandHistory
	{
		protected var _undoCommands : Vector.<IUndoableCommand>;

		protected var _redoCommands : Vector.<IUndoableCommand>;

		private var execCommand : IUndoableCommand;

		public function CommandHistory()
		{
			clear();
		}


		/**
		 * undo the latest undoable command(s) if they are available
		 * 
		 * @param levels num of commands to undo
		 */
		public function undo(levels : int = 1) : void
		{
			for (var i : int = 1; i <= levels; i++)
			{
				if ( canUndo )
				{
					var command : IUndoableCommand = _undoCommands.pop();
					command.unexecute();
					_redoCommands.push(command);
					notifyChanged();
				}
			}
		}


		/**
		 * redo the latest undoable command(s) if they are available
		 * 
		 * @param levels num of commands to redo
		 */
		public function redo(levels : int = 1) : void
		{
			for (var i : int = 1; i <= levels; i++)
			{
				if ( canRedo )
				{
					var command : IUndoableCommand = _redoCommands.pop();
					// prevent executing command from being readded
					execCommand = command;
					command.execute();
					execCommand = null;
					_undoCommands.push(command);
					notifyChanged();
				}
			}
		}


		/**
		 * find out if undo is possible
		 * 
		 * @return Boolean true if one or more commands are available to undo
		 */
		public function get canUndo() : Boolean
		{
			return _undoCommands.length > 0;
		}


		/**
		 * find out if redo is possible
		 * 
		 * @return Boolean true if one or more commands are available to redo
		 */
		public function get canRedo() : Boolean
		{
			return _redoCommands.length > 0;
		}


		/**
		 * clear all history (undo and redo)
		 */
		public function clear() : void
		{
			_undoCommands = new Vector.<IUndoableCommand>();
			_redoCommands = new Vector.<IUndoableCommand>();
		}


		/**
		 * add an undoable command
		 * 
		 * Note commands must only be added once.
		 * 
		 * @throws flash.errors.IllegalOperationError if command already in either undo or redo list
		 */
		public function add(command : IUndoableCommand) : void
		{
			if ( !command || command == execCommand ) return;

			if ( isAdded(command) )
			{
				throw new IllegalOperationError("CommandHistory.add() fails - command has already been added " + command);
			}
			_undoCommands.push(command);
			_redoCommands = new Vector.<IUndoableCommand>();
			notifyChanged();
		}


		/**
		 * find out if command has already been added
		 * 
		 * @return Boolean true if command has been added
		 */
		public function isAdded(command : IUndoableCommand) : Boolean
		{
			return _undoCommands.indexOf(command) > -1 || _redoCommands.indexOf(command) > -1;
		}


		/**
		 * get number of undos possible
		 * 
		 * @return int the number of undo levels
		 */
		public function get undoLevels() : int
		{
			return _undoCommands.length;
		}


		/**
		 * get number of redos possible
		 * 
		 * @return int the number of redo levels
		 */
		public function get redoLevels() : int
		{
			return _redoCommands.length;
		}


		/**
		 * dispatch changed event
		 */
		protected function notifyChanged() : void
		{
			if( !eventDispatcher ) return;
			dispatch(new HistoryEvent(HistoryEvent.CHANGED));
		}


		public function toString() : String
		{
			return this + " undos = " + _undoCommands.length + " redos = " + _redoCommands.length;
		}
	}
}
