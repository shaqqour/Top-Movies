class Director
    extend Creation::ClassMethods
    include Creation::InstanceMethods
    attr_accessor :name
    attr_reader :movies
    @@all = []

    def initialize(name)
        @name = name
        @movies = []
        @@all << self
    end

    def add_movie(movie)
        if !@movies.include?(movie)
            @movies << movie
        end
        if !movie.directors.include?(self)
            movie.directors << self
        end
    end

    def self.all
        @@all
    end

end