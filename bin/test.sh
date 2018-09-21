#!/bin/sh

echo "Definition syntax validation passed, running tests on other languages ..."
echo

cd bin

TEST_RUN=test_run/

# Clean everything!
echo "Cleaning past runs from '$TEST_RUN'..."
rm -rf $TEST_RUN
rc=$?

if [ $rc != 0 ]; then
  echo "Unable to clean previous run, exiting with rc=$rc"
  exit $rc
fi

echo "Cleaning successful!"
echo

sh ruby.sh $TEST_RUN
echo
rc=$?

if [ $rc != 0 ]; then
  echo "Ruby tests failed! View the errors above to see what you should fix. If you are really stuck please open an issue and maintainers will help you!"
  exit $rc
fi

echo "Ruby tests PASSED!"

### Other languages can be added here

echo
echo "ALL TESTS PASSED!"
