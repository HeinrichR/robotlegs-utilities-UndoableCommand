/*
 * Copyright (c) 2012 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */
package org.robotlegs.utilities.undoablecommand.interfaces
{
	/**
	 * @author derek
	 */
	public interface IUndoableCommand
	{

		function execute() : void;


		function unexecute() : void;
	}
}
