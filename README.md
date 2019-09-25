# Rule Engine

Simple keyword matching engine

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     rule_engine:
       github: policr-project/rule_engine
   ```

2. Run `shards install`

## Usage

```crystal
require "rule_engine"

rule = RuleEngine.parse! "[柬埔寨|东南亚 菠菜|博彩 招聘|微信]"

rule.match? "东南亚招聘菠菜"   # => true
rule.match? "柬埔寨博彩加微信" # => true
```

## Contributing

1. Fork it (<https://github.com/policr-project/rule_engine/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Hentioe](https://github.com/policr-project/rule_engine) - creator and maintainer
