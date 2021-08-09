require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    # The new action will be used to display a new random grid and a form.
    @letters = []
    10.times do
      @letters << ('A'...'Z').to_a[rand(25)]
    end
  end

  def score
    # The form will be submitted (with POST) to the score action.
    @word = params[:word]
    @letters = params[:letters]
    if true_or_false((@word.upcase.split(//)), (@letters.split(" "))) == true && english_word?(@word)
      return @score = "Congratulations! #{@word.capitalize} is a valid english word!"
    elsif true_or_false((@word.upcase.split(//)), (@letters.split(" "))) == false
      return @score = "Sorry but #{@word.capitalize} can't be built out of #{@letters}"
    else
      return @score = "Sorry but #{@word.capitalize} does not seem to be a valid english word"
    end
  end

  private

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def true_or_false(word_array, letters_array)
    word_array.all? do |letter|
      word_array.count(letter) <= letters_array.count(letter)
    end
  end

end
