class MovieScraper
    def self.scraper(url)
        html = open(url)
        doc = Nokogiri::HTML(html)
        content = doc.css("div .row.countdown-item")
        content.each_with_index do |movie, idx|
            movie_name = movie.css("div h2 a").text.strip
            movie_year = movie.css(".subtle.start-year").text.strip.split("(").join.split(")").join
            movie_rating = movie.css(".tMeterScore").text.strip
            movie_critics = movie.css("div.info.critics-consensus").text.strip.split("Critics Consensus:").join
            movie_synopsis = movie.css("div.info.synopsis").text.split("Synopsis:").join.split("[More]").join.strip
            movie_actors = movie.css("div.info.cast").text.strip.split("Starring:").join.strip.split(", ")
            movie_directors = movie.css("div.info.director").text.strip.split("Directed By:").join.strip.split(", ")

            movie_details = {
                :name => movie_name,
                :year => movie_year,
                :rating => movie_rating,
                :critics => movie_critics,
                :synopsis => movie_synopsis,
                :actors => movie_actors,
                :directors => movie_directors,
            }

            Movie.new_from_hash(movie_details)

        end
    end

end

#MovieScraper.scraper("https://editorial.rottentomatoes.com/guide/200-essential-movies-to-watch-now/")