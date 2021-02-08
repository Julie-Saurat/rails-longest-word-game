class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @grid = params[:letters]
    @response = params[:response]

    @valid = valid_on_grid?(@response, @grid)
    @english = english?(@response)

  end

  private 
  
  def valid_on_grid?(attempt, grid)
    letters_of_attemp = attempt.upcase.split(//)
    letters_of_attemp.all? { |letter| letters_of_attemp.count(letter) <= grid.count(letter) }
  end

  def english?(attempt)
    fetch("https://wagon-dictionary.herokuapp.com/#{attempt}")
      .then(response => response.json())
      .then((data) => {
        if data["found"] == true
          return true
        else
          return false
        end
    })


    dictionary = JSON.parse(open(url).read)
  end



end


# fait ulterieurement
# if english?(attempt) != true
#   result[:score] = 0
#   result[:message] = "not an english word"
# elsif on_grid?(attempt, grid) != true
#   result[:score] = 0
#   result[:message] = "Your world is not in the grid!"
# elsif amont_of_letters(attempt, grid) != true
#   result[:score] = 0
#   result[:message] = "not in the grid"
# else
#   # faire une methode pour comparer le temp et la longueur
#   result[:score] = score(attempt, start_time, end_time)
#   result[:message] = "well done"
# end

# # calculer le temps de reponse
# def answer_time(start_time, end_time)
# time = (end_time - start_time)
# return time.to_i
# end

# # verifier que le mot soit anglais et verifier si les lettre sont bien celles de la grid utilise 1 fois
# def english?(attempt)
    # fetch("https://wagon-dictionary.herokuapp.com/:word")
    #   .then(response => response.json())
    #   .then((data) => {

    # })


# url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
# dictionary = JSON.parse(open(url).read)
# if dictionary["found"] == true
#   return true
# else
#   return false
# end
# end

# # verifier si les lettre sont bien celles de la grid utilise 1 fois
# def on_grid?(attempt, grid)
# letters_of_attemp = attempt.upcase.split(//)
# letters_of_attemp.all? { |letter| grid.include?(letter) }
# end

# def amont_of_letters(attempt, grid)
# letters_of_attemp = attempt.upcase.split(//)
# letters_of_attemp.all? { |letter| letters_of_attemp.count(letter) <= grid.count(letter) }
# end
