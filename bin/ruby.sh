#!bin/sh

TEST_RUN=$1

# Pull target ruby version and run tests
mkdir -p $TEST_RUN
cd $TEST_RUN
echo "Running Ruby Tests...."
git clone git@github.com:holidays/holidays.git 1>> /dev/null 2>> /dev/null

cd holidays
git checkout tags/v6.3.0 -b v6.3.0 1>> /dev/null

echo
echo "Running ruby setup ..."
make setup  1>> /dev/null
rc=$?

if [ $rc != 0 ]; then
  echo "Unable to setup for ruby tests, errors above".
  exit $rc;
fi

echo
echo "Ruby setup completed, running tests ..."
make test
rc=$?

if [ $rc != 0 ];  then
  exit $rc;
fi

cd ../..
