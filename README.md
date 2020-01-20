# CollectionObject

Sometimes you want to extract methods that work with the same collection into separate object.
We created a boilerplate code in a form of a mixin to quickly solve you problem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'collection_object'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install collection_object

## Usage

```ruby
# line_items.rb
class LineItems
  include CollectionObject[:items]

  class Item < Struct.new(:code, :name); end

  def self.from_file(input)
    items = new
    input.strip.split("\n").each do |line|
      items << Item.new(*line.split(' '))
    end
    items
  end

  private_class_method :new

  def find_by_code(product_code)
    detect { |line_item| line_item.code == product_code }
  end

  def filter_by_name(product_name)
    select { |line_item| line_item.name.match(Regexp.new(product_name, 'i')) }
  end
end
```
Than in console
```
irb> items = LineItems.from_file("LM Lemon\nCHS Cheese")
=> #<LineItems:0x007fdda552de58 @items=[#<struct LineItems::Item code="LM", count="Lemon">, #<struct LineItems::Item code="CHS", count="Cheese">]>
irb> items.find_by_code('LM')
=> #<struct LineItems::Item code="LM", count="Lemon">
irb> items.filter_by_name('Ch')
=> [#<struct LineItems::Item code="CHS", name="Cheese">]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/andriy-baran/collection_object. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CollectionObject project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/andriy-baran/collection_object/blob/master/CODE_OF_CONDUCT.md).
