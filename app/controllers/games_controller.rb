require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = [*'a'..'z', *'a'..'z'].to_a.sample(10)
  end

  def score
    letters = params[:letters].upcase.split
    @answer = params[:word]
    # check is work is valid
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    check_word = URI.open(url).read
    word = JSON.parse(check_word)
    if word['found'] == false
      @answer_one = "Sorry but <u>#{@answer.upcase}</u> is not a VALID word".html_safe
    elsif word['found'] == true && @answer.upcase.chars.all? { |letter| letters.include?(letter) }
      @answer_one = "Congratualation #{@answer.upcase} is a valid English Word"
    else
      @answer_one = "Sorry but <u>#{@answer.upcase}</u> can not be built out of #{letters.join(', ')}".html_safe
    end
  end
end
