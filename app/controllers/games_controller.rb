class GamesController < ApplicationController
  def new
    session[:letters] = generate_random_letters(10)
    @letters = session[:letters]
  end

  def score
    user_word = params[:word]
    @score = calculate_score(user_word, session[:letters])
  end

  private

  def generate_random_letters(count)
    Array.new(count) { random_letter }
  end

  def random_letter
    ("a".."z").to_a.sample
  end

  def calculate_score(word, letters)
    letter_count = Hash.new(0)
    letters.each { |letter| letter_count[letter] += 1 }

    word.each_char do |char|
      return 0 unless letters.include?(char) && letter_count[char] > 0
      letter_count[char] -= 1
    end
    word.length
  end
end
