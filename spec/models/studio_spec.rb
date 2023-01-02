require 'rails_helper'

RSpec.describe Studio do
  describe 'relationships' do
    it {should have_many :movies }
    it {should have_many :actors }
  end

  describe 'instance methods' do
    before :each do
      @universal = Studio.create!({name: 'Universal Studios', location: 'Hollywood'})
      @paramount = Studio.create!({name: 'Paramount Pictures', location: 'Dana Point'})
      @warner_brothers = Studio.create!({name: 'Warner Brothers Studios', location: 'Inglewood'})

      @toy = @universal.movies.create!({title: 'Toy Story', creation_year: '1995', genre: 'animation'})
      @monty = @universal.movies.create!({title: 'Monty Python and the Holy Grail', creation_year: '1972', genre: 'comedy'})
      @airplane = @universal.movies.create!({title: 'Airplane!', creation_year: '1975', genre: 'comedy'})
      @star = @paramount.movies.create!({title: 'Star Wars', creation_year: '1977', genre: 'sci-fi'})
      @italian = @paramount.movies.create!({title: 'The Italian Job', creation_year: '1968', genre: 'crime'})

      @meryl = @toy.actors.create!({name: 'Meryl Streep', age: 73})
      @tom = @toy.actors.create!({name: 'Tom Hanks', age: 65})
      @michael = @italian.actors.create!({name: 'Michael Caine', age: 90})
      @john = @monty.actors.create!({name: 'John Cleese', age: 82})
      @mark = @star.actors.create!({name: 'Mark Hamill', age: 75})
      @harrison = @star.actors.create!({name: 'Harrison Ford', age: 80})
      @leslie = @airplane.actors.create!({name: 'Leslie Nielsen', age: 84})

      ActorMovie.create!({actor_id: @leslie.id, movie_id: @monty.id})
      ActorMovie.create!({actor_id: @harrison.id, movie_id: @italian.id})
    end

    it 'returns the unique actors' do
      expect(@universal.unique_actors).to eq([@meryl, @tom, @john, @leslie])
    end
  end
end
