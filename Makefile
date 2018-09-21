default: validate

DEFINITION_VERSION=2.3.0
RUBY_VERSION=6.3.0

validate:
	bundle exec ruby lib/validation/run.rb
	DEFINITION_VERSION=$(DEFINITION_VERSION) RUBY_VERSION=$(RUBY_VERSION) bin/test.sh
test:
	bundle exec rspec

clean:
	rm -rf test_run/

.PHONY: validate,test
