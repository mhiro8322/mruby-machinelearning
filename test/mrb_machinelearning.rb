##
## MachineLearning Test
##

assert("MachineLearning#hello") do
  t = MachineLearning.new "hello"
  assert_equal("hello", t.hello)
end

assert("MachineLearning#bye") do
  t = MachineLearning.new "hello"
  assert_equal("hello bye", t.bye)
end

assert("MachineLearning.hi") do
  assert_equal("hi!!", MachineLearning.hi)
end
