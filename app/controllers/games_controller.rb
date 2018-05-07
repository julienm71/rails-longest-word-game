require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase

    response = open("https://wagon-dictionary.herokuapp.com/#{@word}")
    json = JSON.parse(response.read)

    if @word.chars.all? { |letter| @word.count(letter) <= params[:letters].split(" ").count(letter) }

      if json['found'] == true
        @message = "Well done!"
      else
        @message = "Not an english word."
      end
    else
      @message = "Not a word from the given letters."
    end
  end
end
