module Creation

    module ClassMethods
        def create(name_str)
            self.new(name_str)
        end

        def find_by_name(name_str)
            self.all.find { |item| item.name == name_str }
        end

        def find_or_create_by_name(name_str)
            if self.find_by_name(name_str)
                self.find_by_name(name_str)
            else
                self.create(name_str)
            end
        end

        def destroy_all
            self.all.clear
        end
    end

    module InstanceMethods
        def remove_movie(movie)
            movies.delete(movie)
        end
    end

end