# Multilingual

Provides three models (`Multilingual::`):
1. `Language` each represented by a unique ISO-639-1 two-letter code.
2. `Translation` a polymorphic model that represents the name/translation of any
   other model in a particular language. Can optionally have a translation type
   if you want to track information about the translation itself.
3. `TranslationType` represents a quality of the associated translation. Given
   by a unique name and integer level. Examples are automatic, beginner,
   intermediate, expert, or similar.

## Usage
How to use my plugin.

If you want to use translation types, your application should open the class
`Multilingual::TranslationType` and add the following association:

```ruby
belongs_to :type, class_name: 'TranslationType'
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'multilingual'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install multilingual
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
