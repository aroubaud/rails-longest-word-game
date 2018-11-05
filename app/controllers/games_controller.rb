require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      letter = ('A'...'Z').to_a.sample
      @letters << letter
    end
  end

  def score
    @word = params[:word].upcase
    @letters = params[:grid].split('')

    dictionary = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{@word}").read)

    if dictionary['found']
      if @word.split('').all? { |letter| @word.count(letter) <= @letters.count(letter) }
        @message = "Congratulations! #{@word} is a valid English word!"
      else
        @message = "Sorry but #{@word} can't be built out of #{@letters}"
      end
    else
      @message = "Sorry but #{@word} does not seem to be a valid English word..."
    end
  end
end
