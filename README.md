# mruby-machinelearning   [![Build Status](https://travis-ci.org/mhiro8322/mruby-machinelearning.png?branch=master)](https://travis-ci.org/mhiro8322/mruby-machinelearning)
MachineLearning class
## install by mrbgems
- add conf.gem line to `build_config.rb`

```ruby
MRuby::Build.new do |conf|

    # ... (snip) ...

    conf.gem :github => 'mhiro8322/mruby-machinelearning'
end
```
## example
```ruby
p MachineLearning.hi
#=> "hi!!"
t = MachineLearning.new "hello"
p t.hello
#=> "hello"
p t.bye
#=> "hello bye"
```

## License
under the MIT License:
- see LICENSE file
