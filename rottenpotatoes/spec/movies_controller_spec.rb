require 'rails_helper'
require 'spec_helper'
require 'movies_controller'

describe MoviesController, type: :controller do
    
    describe '#find_by_director' do
        describe 'when called on a movie with a director' do
            before :each do
                @director = "George Lucas"
                @another_movie1 = double(title: 'fake_movie_reult1', director:@director)
                @another_movie2 = double(title: 'fake_movie_reult2', director:@director)
                @fake_results =[@another_movie1, @another_movie2]
                @movie_id = '16'
                @movie = double(title: 'fake_movie', id: @movie_id, director: @director, find_movies_with_same_director: @fake_reults)
            end
            it "should find the movie whose director we're searching by" do
                expect(Movie).to receive(:find){@movie}
                get :find_by_director, id: @movie_id
            end
            it 'should find the director of the movie in question' do
                allow(Movie).to receive(:find){@movie}
                expect(@movie).to receive(:director){@director}
                get :find_by_director, id: @movie_id
            end
            it 'should call the model method that searches for movies with the same director' do
                allow(Movie).to receive(:find){@movie}
                allow(@movie).to receive(:director){@director}
                expect(@movie).to receive(:find_movies_with_same_director) {@fake_results}
                get :find_by_director, id: @movie_id
            end
            it 'should select the Find By Director template for rendering' do
                allow(Movie).to receive(:find){@movie}
                allow(@movie).to receive(:director){@director}
                allow(@movie).to receive(:find_movies_with_same_director){@fake_results}
                get :find_by_director, id: @movie_id
                expect(response).to render_template('find_by_director')
            end
        end
        describe 'when called on a movie without a director' do
            before :each do
                @id = '20'
                @movie_without_director = double('some movie', title: "fdsafd", id: @id, director: nil)
                @movie_with_director = double('some other movie', title: 'some other movie', director: 'some guy')
            end
            it 'should not find any movies with the same director' do
                allow(Movie).to receive(:find){@movie_without_director}
                allow(@movie_without_director).to receive(:director){nil}
                expect(@movie_without_director).to receive(:find_movies_with_same_director){nil}
                get :find_by_director, id: @id
            end
            it 'should show the "no director" message' do
                allow(Movie).to receive(:find){@movie_without_director}
                allow(@movie_without_director).to receive(:director){nil}
                allow(@movie_without_director).to receive(:find_movies_with_same_director){nil}
                get :find_by_director, id: @id
                expect(flash[:notice]).to eq("'#{@movie_without_director.title}' has no director info")
            end
            it 'should go back to the home page' do
                allow(Movie).to receive(:find){@movie_without_director}
                allow(@movie_without_director).to receive(:director){nil}
                allow(@movie_without_director).to receive(:find_movies_with_same_director){nil}
                get :find_by_director, id: @id
                expect(response).to redirect_to movies_path
            end
        end
    end
end
    
                
            