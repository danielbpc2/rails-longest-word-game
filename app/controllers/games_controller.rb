require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @grid = ('A'..'Z').to_a
    @letters = []
    10.times { @letters << @grid.sample(1)}
    @start_time = Time.now
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def score
    @end_time = Time.now
    @word = params['word-input']
    @letters = params['letters']
    @start_time = params['start_time']
    urlanswer = "https://wagon-dictionary.herokuapp.com/#{@word}"
    answer_serialized = open(urlanswer).read
    answer = JSON.parse(answer_serialized)
    if answer["found"] == true
      if included?(@word.upcase, @letters)
        @score = answer["length"] * 100 / (@end_time.to_i - @start_time.to_time.to_i)
        @message = "Well done!"
        @time = @end_time.to_i - @start_time.to_time.to_i
        cookies[:score] = @score if @score.to_i > cookies[:score].to_i
      else
        @score = 0
        @message = "The word is not in the grid."
        @time = @end_time.to_i - @start_time.to_time.to_i
      end

    elsif answer["found"] == false
      @score = 0
      @message = "oh no! it is not an english word"
      @time = @end_time.to_i - @start_time.to_time.to_i
    end
  end
end
