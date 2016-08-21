default: validate

validate:
	bundle exec ruby validate.rb

test:
	bundle exec rspec

.PHONY: validate,test
