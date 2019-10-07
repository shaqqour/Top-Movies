class Movie
    extend Creation::ClassMethods
    attr_accessor :name, :year, :rating
    attr_reader :directors, :actors, :critics, :synopsis
    @@all = []

    def initialize(name)
        @name = name
        @directors = []
        @actors = [] 
        @@all << self
    end

    def self.new_from_hash(details)

        movie = self.find_or_create_by_name(details[:name])
        movie.year = details[:year]
        movie.rating = details[:rating]
        movie.critics = details[:critics]
        movie.synopsis = details[:synopsis]

        details[:actors].each do |actr|
            actor = Actor.find_or_create_by_name(actr)
            movie.add_actor(actor)
        end

        details[:directors].each do |drctr|
            director = Director.find_or_create_by_name(drctr)
            movie.add_director(director)
        end
        
    end

    def add_actor(actor)
        if !@actors.include?(actor)
            @actors << actor
        end
        actor.add_movie(self)
    end

    def add_director(director)
        if !@directors.include?(director)
            @directors << director
        end
        director.add_movie(self)
    end

    def critics=(critics)
        @critics = critics
    end

    def synopsis=(synopsis)
        @synopsis = synopsis
    end

    def self.all
        @@all
    end

    def self.remove_movie(movie)
        actors = movie.actors
        directors = movie.directors
        actors.each { |actor| actor.remove_movie(movie) }
        directors.each { |director| director.remove_movie(movie) }
        movie.actors.clear
        movie.directors.clear
        @@all.delete(movie)
    end

end