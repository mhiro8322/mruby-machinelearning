##
# MachineLearning module Test
# Copyright (c) Hiroyuki Matsuzaki 2015
#
# See Copyright Notice in LICENSE
#

assert("MachineLearning#VERSION") do
  v = MachineLearning::VERSION
  assert_equal("0.0.1", v)
end

##
# NaiveBayes class Test
#

@@nb = MachineLearning::NaiveBayes.new

assert("NaiveBayes.new") do
  @@nb.class == MachineLearning::NaiveBayes
  @@nb.vocabularies.class == Array
  @@nb.category_count.class == Hash
  @@nb.word_count.class == Hash
end

assert("NaiveBayes.word_count_up") do
  @@nb.word_count_up("word_1", "category_1")
  @@nb.vocabularies.size == 1
  @@nb.vocabularies[0] == "word_1"
  @@nb.word_count["category_1"]["word_1"] == 1

  @@nb.word_count_up("word_1", "category_1")
  @@nb.word_count["category_1"]["word_1"] == 2

  @@nb.word_count_up("word_2", "category_1")
  @@nb.vocabularies.size == 2
  @@nb.vocabularies[1] == "word_2"
  @@nb.word_count["category_1"]["word_2"] == 1
end

assert("NaiveBayes.category_count_up") do
  @@nb.category_count_up("category_1")
  @@nb.category_count["category_1"] == 1
  @@nb.category_count_up("category_1")
  @@nb.category_count["category_1"] == 2
  @@nb.category_count_up("category_2")
  @@nb.category_count["category_2"] == 1
end

@@nb = MachineLearning::NaiveBayes.new

assert("NaiveBayes.training") do
  @@nb.training(["word_1"],"category_1")
  @@nb.training(["word_1","word_2"],"category_1")
  @@nb.training(["word_1","word_2","word_3"],"category_1")
  @@nb.category_count["category_1"] == 3
  @@nb.word_count["category_1"]["word_1"] == 3
  @@nb.word_count["category_1"]["word_2"] == 2
  @@nb.word_count["category_1"]["word_3"] == 1

  @@nb.training(["word_1"],"category_2")
  @@nb.category_count["category_2"] == 1
  @@nb.word_count["category_2"]["word_1"] == 1

  @@nb.priorprob("category_1") == 3 / 4
end

@@nb = MachineLearning::NaiveBayes.new

assert("NaiveBayes.word_count_in_category") do
  @@nb.training(["word_1"],"category_1")
  @@nb.training(["word_1","word_2"],"category_1")
  @@nb.training(["word_1","word_2","word_3"],"category_1")
  @@nb.word_count_in_category("word_4","category_1") == 0
  @@nb.word_count_in_category("word_1","category_1") == 3
end

@@nb = MachineLearning::NaiveBayes.new

assert("NaiveBayes.all_word_count_in_category") do
  @@nb.training(["word_1"],"category_1")
  @@nb.training(["word_1","word_2"],"category_1")
  @@nb.training(["word_1","word_2","word_3"],"category_1")
  @@nb.all_word_count_in_category("category_1") == 6
end

assert("NaiveBayes.priorprob") do
  @@nb.priorprob("category_1") == 1.0
  @@nb.training(["word_1"],"category_2")
  @@nb.priorprob("category_1") == 0.75
end

@@nb = MachineLearning::NaiveBayes.new

#assert("NaiveBayes.wordprob") do
#  @@nb.training(["word_1"],"category_1")
#  @@nb.training(["word_1","word_2"],"category_1")
#  @@nb.training(["word_1","word_2","word_3"],"category_1")
#  @@nb.training(["word_1"],"category_2")
#  @@nb.all_word_count_in_category("category_1") == 6
#  @@nb.wordprob("word_10","category_1") == 1/9
#end
