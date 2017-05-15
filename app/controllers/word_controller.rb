require 'open-uri'
require 'json'

BASE_URL = "https://api-platform.systran.net/translation/text/translate"
API_KEY = "f344bd65-939f-4a5d-be99-c0e46f227389"

class WordController < ApplicationController
  def game
    @grid = ""
    8.times do
      @grid << ('A'..'Z').to_a.sample
    end
    @grid

  end

  def score
    @grid = params[:grid].to_s
    @word = params[:input]
    @grid_chars = @grid.upcase.chars
    @word_chars = @word.upcase.chars
    @result = ''


    json = JSON.parse(open("#{BASE_URL}?source=en&target=fr&key=#{API_KEY}&input=#{@word}").read)
    @result = json['outputs'].first['output']
    return nil if @result == @word
    @result

    @word_hash = {}
    @word_chars.each do |char|
      if @word_hash.key?(char)
        @word_hash[char] += 1 # Incrementation
      else
        @word_hash[char] = 1 # Initialisation
      end
    end

    @grid_hash = {}
    @grid_chars.each do |char|
      if @grid_hash.key?(char)
        @grid_hash[char] += 1 # Incrementation
      else
        @grid_hash[char] = 1 # Initialisation
      end
    end

    @word_hash.each do |key, value|
      return false unless @grid_hash.key?(key)
      return false if value > @grid_hash[key]
    end

    # def calculate_score(attempt, time)
    #   (attempt.chars.count * 100) / time
    # end


    # def get_message(translation, attempt, grid)
    #   message = 'well done'
    #   message = 'not an english word' if translation.nil?
    #   message = 'not in the grid' unless in_the_grid(attempt, grid)
    #   message
    # end

    # def run_game(attempt, grid, start_time, end_time)
    #   time = end_time - start_time
    #   translation = translate(attempt)
    #   score = calculate_score(attempt, time)
    #   message = get_message(translation, attempt, grid)
    #   score = 0 if message != 'well done'
    #   { time: time, translation: translation, score: score, message: message }
    # end
  # end
  end
end
