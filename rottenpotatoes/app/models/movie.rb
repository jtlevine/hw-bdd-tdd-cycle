class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def find_movies_with_same_director
      self.class.where director: director if !director.blank?
  end
end
