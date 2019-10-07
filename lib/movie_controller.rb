require_relative "../config/environment.rb"

class MovieController

    def initialize(url = "https://editorial.rottentomatoes.com/guide/200-essential-movies-to-watch-now/")
        MovieScraper.scraper(url)
    end
    def run
        puts "Welcome To Rotten Tomatoes Best 200 Movies Must Watch".blue
        view_menu
        input = gets.chomp.downcase
        until input == "exit"
            case input
            when "list movies"
                list_movies
            when "list actors"
                list_actors
            when "list directors"
                list_directors
            when "list actor movies"
                list_movies_by_actor
            when "list director movies"
                list_movies_by_director
            when "watch movie"
                watch_movie
            when "view menu"
                view_menu
            when "remove movie"
                remove_movie
            else
                puts "Invalid entry, try again!".red
            end
            puts
            view_menu
            input = gets.chomp.downcase
            system "clear"
        end
    end
    def view_menu
        puts "To list all movies, enter 'list movies'.".blue
        puts "To list all actors, enter 'list actors'.".blue
        puts "To list all directors, enter 'list directors'.".blue
        puts "To list all of the movies of a particular actor, enter 'list actor movies'.".blue
        puts "To list all of the movies of a particular director, enter 'list director movies'.".blue
        puts "To watch a movie, enter 'watch movie'.".blue
        puts "To remove a movie, enter 'remove movie'".blue
        puts "To quit, type 'exit'.".blue
        puts "What would you like to do?".blue
    end
    def list_movies
        movies = Movie.all
        movies.each_with_index do |movie, idx|
            puts "#{idx+1}. #{movie.name} #{movie.year} #{movie.rating}.".yellow
            puts "Actors: #{movie.actors.map{ |ac| ac.name }.join(", ")}.".yellow
            puts "Directed By: #{movie.directors.map{ |dir| dir.name }.join(", ")}.".yellow
            puts "Synopsis: #{movie.synopsis}.".yellow
            puts "Critics: #{movie.critics}.".yellow
            puts
            puts
        end
    end
    def list_actors
        actors = Actor.all.sort { |a, b| a.name <=> b.name }
        actors.each_with_index do |actor, idx|
            puts "#{idx+1}. #{actor.name}".yellow
        end
    end
    def list_directors
        directors = Director.all.sort { |a, b| a.name <=> b.name }
        directors.each_with_index do |director, idx|
            puts "#{idx+1}. #{director.name}".yellow
        end
    end
    def list_movies_by_actor
        puts "Please the actor name:".blue
        actor = gets.chomp.split.map{ |part| part.capitalize }.join(" ")
        if Actor.find_by_name(actor)
            movies = Actor.find_by_name(actor).movies.sort { |a, b| a.name <=> b.name }
            movies.each_with_index do |movie, idx|
                puts "#{idx+1}. #{movie.name} #{movie.year} #{movie.rating}.".yellow
            end
        else
            puts "Sorry, actor is not found in this database!".red
        end
    end
    def list_movies_by_director
        puts "Please enter the director name:".blue
        director = gets.chomp.split.map{ |part| part.capitalize }.join(" ")
        if Director.find_by_name(director)
            movies = Director.find_by_name(director).movies.sort { |a, b| a.name <=> b.name }
            movies.each_with_index do |movie, idx|
                puts "#{idx+1}. #{movie.name} #{movie.year} #{movie.rating}.".yellow
            end
        else
            puts "Sorry, director is not found in this database!".red
        end
    end
    def watch_movie
        movies = Movie.all.sort { |a, b| a.name <=> b.name }
        movies.each_with_index do |movie, idx|
            puts "#{idx+1}. #{movie.name} #{movie.year} #{movie.rating}."
        end
        puts "Which movie number would you like to watch?".blue
        number = gets.chomp.to_i
        if number.between?(1, movies.length)
            puts "Playing #{movies[number-1].name} by #{movies[number-1].directors.map{ |dir| dir.name }.join(", ")}.".green
        else
            puts "Movie number is not found!".red
        end
    end
    def remove_movie
        movies = Movie.all.sort { |a, b| a.name <=> b.name }
        movies.each_with_index do |movie, idx|
            puts "#{idx+1}. #{movie.name} #{movie.year} #{movie.rating}."
        end
        puts "Which movie number would you like to remove from this list?".blue
        number = gets.chomp.to_i
        if number.between?(1, movies.length)
            Movie.remove_movie(movies[number-1])
            puts "Selected movies was successfully removed from your database!".green
        else
            puts "Movie number is not found!".red
        end
    end
end