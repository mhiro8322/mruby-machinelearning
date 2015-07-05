##
# MachineLearning module
# Copyright (c) Hiroyuki Matsuzaki 2015
#
# See Copyright Notice in LICENSE
#

module MachineLearning

  ##
  # NaiveBayes class
  #
  class NaiveBayes

    ##
    # call-seq:
    #     nb.word_count_up(word, category)
    #
    def word_count_up(word, category)
      unless self.vocabularies.include?(word)
        # new word
        self.vocabularies << word
      end
      if self.word_count.include?(category)
        if self.word_count[category].include?(word)
          self.word_count[category][word] += 1
        else
          # new word in this category
          self.word_count[category].store(word, 1)
        end
      else
        # new category
        self.word_count.store(category, Hash.new(0))
        self.word_count[category].store(word, 1)
      end
    end

    ##
    # call-seq:
    #     nb.category_count_up(category)
    #
    def category_count_up(category)
      if self.category_count.include?(category)
        self.category_count[category] += 1
      else
        self.category_count.store(category, 1)
      end
    end

    ##
    # call-seq:
    #     nb.training(words, category)
    #
    # ex)  words = ["word_1","word_2", ...]
    #
    def training(words, category)
      words.each do |w|
        self.word_count_up(w, category)
      end
      self.category_count_up(category)
    end

    ##
    # call-seq:
    #     nb.word_count_in_category(word, category)
    #
    def word_count_in_category(word, category)
      if self.word_count[category].include?(word)
        return self.word_count[category][word]
      else
        return 0
      end
    end

    ##
    # call-seq:
    #     nb.all_word_count_in_category(category)
    #
    def all_word_count_in_category(category)
      sum = 0
      self.word_count[category].each do |w, count|
        sum += count
      end
      return sum
    end

    ##
    # call-seq:
    #     nb.priorprob(category) => P(cat)
    #
    def priorprob(category)
      sum = 0
      self.category_count.each do |cat, count|
        sum += count
      end
      return self.category_count[category] / sum
    end

    ##
    # call-seq:
    #     nb.wordprob(word, category) => P(word|cat)
    #
    def wordprob(word, category)
      numerator = self.word_count_in_category(word, category) + 1
      denominator = self.all_word_count_in_category(category) + self.vocabularies.size
      return numerator / denominator
    end

    ##
    # call-seq:
    #     nb.category_score(words, category)
    #
    def category_score(words, category)
      score = Math.log(self.priorprob(category))
      words.each do |w|
        score += Math.log(self.wordprob(w, category))
      end
      return score
    end

    ##
    # call-seq:
    #     nb.category_score(words)
    #
    def classifier(words)
      best_category = "others."
      max = 0.0
      self.category_count.each do |cat, count|
        prob = self.score(words, cat)
        if prob > max
          best_category = cat
          max = prob
        end
      end
      return best_category
    end

  end # class NaiveBayes

end
