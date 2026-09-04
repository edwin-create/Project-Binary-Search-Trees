# Project: Binary Search Trees (Ruby)

Simple Binary Search Tree implementation in Ruby with accompanying RSpec tests.

## What this repo contains

- `lib/node.rb` — Node class for BST nodes.
- `lib/tree.rb` — Tree class implementing building, insertion, search (`include?`), deletion, and pretty printing.
- `spec/` — RSpec tests for `Node` and `Tree` behavior.
- `Gemfile` — project dependencies for running the tests.

## Setup

Install gems and run the test suite:

```bash
bundle install
bundle exec rspec
```

If you prefer to run `rspec` directly and you have the gems installed globally, running `rspec` in the project root also works.

## Usage (quick)

```ruby
require_relative 'lib/node'
require_relative 'lib/tree'

arr = [1, 2, 3, 4, 5, 6, 7]
t = Tree.new(arr)

# insert
t.insert(8)

# check membership
puts t.include?(4) # => true

# pretty print
t.pretty_print

# delete (note: deletion implemented; supports leaf, one-child, and two-children cases)
t.delete(4)
```

## Notes

- The `Tree#delete` method has been implemented (iterative handling of no-children, one-child, and two-children cases). Run the test suite (`bundle exec rspec`) to verify behavior.

- The tests are the canonical source of expected behavior; if you make changes, run `bundle exec rspec` to verify behavior.

## Contributing

If you want me to implement a safe `delete` that passes the test suite, reply and I'll implement it step-by-step.