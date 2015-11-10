class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def guess(guessed_letter)
    if guessed_letter == ''
      raise ArgumentError
    elsif guessed_letter == nil
      raise ArgumentError
    elsif guessed_letter =~ /[0-9_\W]/
      raise ArgumentError
    end
    
    guessed_letter.downcase!
    
    if @word.include? guessed_letter
      if @guesses.include? guessed_letter
        return false
      else
        @guesses.insert(-1,guessed_letter)
        return true
      end
    else
      if @wrong_guesses.include? guessed_letter
        return false
      else
        @wrong_guesses.insert(-1,guessed_letter)
        return true
      end
    end
  end
  
  def word_with_guesses
    displayed = ''
    @word.each_char do |letter|
      if @guesses.include? letter
        displayed.insert(-1,letter)
      else
        displayed.insert(-1,'-')
      end
    end
    return displayed
  end
  
  def check_win_or_lose
    if @wrong_guesses.length == 7
      return :lose
    elsif @word == word_with_guesses
      return :win
    else
      return :play
    end
  end
end
