# Binary Search Trees Project (Ruby)



This Binary Search Tree implementation is fully working and verified with the project test suite. All methods behave as expected, including tree creation, insertion, search, traversal, deletion, depth/height checks, and balance validation.

## Project status

✅ Completed
✅ All methods working as expected
✅ Test suite passing

## What this repo contains

- `lib/node.rb` — Node class for BST nodes.
- `lib/tree.rb` — Tree class implementing building, insertion, search (`include?`), deletion, traversal methods, height/depth logic, and balancing checks.
- `spec/` — RSpec tests covering the BST functionality.
- `Gemfile` — project dependencies for running the tests.

## Setup

Install gems and run the test suite:

```bash
bundle install
bundle exec rspec
```

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

# delete
t.delete(4)
```

## Verification

The project passes the Ruby test suite and is considered complete for The Odin Project requirements.

## Notes

- The BST logic is implemented and confirmed working through the repository tests.
- If you continue modifying the project, run `bundle exec rspec` to confirm behavior remains correct.