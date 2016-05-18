require 'rails_helper'
require 'spec_helper'
require 'movies_controller'

describe Movie do
    fixtures :movies
    describe "#find_movies_with_same_director" do
        describe "when called on a movie with a director" do
            before :each do
                @same_director_movies = movies(:star_wars).find_movies_with_same_director
            end
            it "should return all movies with the same director" do
                expect(@same_director_movies).to include(movies(:star_wars), movies(:thx))
            end
            it "should not return movies with different directors" do
                expect(@same_director_movies).not_to include(movies(:blade_runner), movies(:alien))
            end
        end
        describe "when called on a movie without a director" do
            it "should return nothing" do
                expect(movies(:alien).find_movies_with_same_director).to be_nil 
            end
        end
    end
end