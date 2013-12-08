# Blf

詰め込み問題のBLF法の実装

This is an implementation of Bottom-Left method to 2-Dimensional Strip Packing Problem.

![](http://gyazo.com/1b8b7db3ee0c3aa859e61996a9f51bc0.png)

## Installation

Add this line to your application's Gemfile:

    gem 'blf'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install blf

## Usage

```ruby
require "blf"

# create the world.
world = BLF.create_world width: 500, height: 500

# add a block with coordinates.
world.add_block_with_location x: 60, y: 0, width: 50, height: 50

(1..50).each do |n|
  w = Random.new(Random.new_seed).rand * 100 + 10
  h = Random.new(Random.new_seed).rand * 100 + 10
  # add a block without coordinates. this becomes a target of allocation.
  world.add_block width: w, height: h
end

# do allocation to all the blocks without coordinates.
world.allocate_all

world.draw
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
