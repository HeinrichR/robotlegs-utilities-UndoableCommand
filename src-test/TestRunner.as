/*
 * Copyright (c) 2012 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */
package
{

	import tests.TestEvents;
	import tests.TestHistory;
	import tests.TestUndoableCommand;

	import org.flexunit.internals.TraceListener;
	import org.flexunit.runner.FlexUnitCore;
	import org.fluint.uiImpersonation.VisualTestEnvironmentBuilder;

	import flash.display.Sprite;

	public class TestRunner extends Sprite
	{

		private var core : FlexUnitCore;


		public function TestRunner()
		{
			// Launch your unit tests by right clicking within this class and select: Debug As > FDT SWF Application

			// Instantiate the core.
			core = new FlexUnitCore();
			// This registers the stage with the VisualTestEnvironmentBuilder, which allows you
			// to use the UIImpersonator classes to add to the display list and remove from within your
			// tests. With Flex, this is done for you, but in AS projects it needs to be handled manually.
			VisualTestEnvironmentBuilder.getInstance(this);

			// Add any listeners. In this case, the TraceListener has been added to display results.
			core.addListener(new TraceListener());

			// There should be only 1 call to run().
			// You can pass a comma separated list (or an array) of tests or suites.
			// You can also pass a Request Object, which allows you to sort, filter and subselect.
			// var request:Request = Request.methods( someClass, ["method1", "method2", "method3"] ).sortWith( someSorter ).filterWith( someFilter );
			// core.run( request );

			var testsToRun : Array = new Array();
			testsToRun.push(TestUndoableCommand);
			testsToRun.push(TestHistory);
			testsToRun.push(TestEvents);
				
			core.run(testsToRun);
		}
	}
}
