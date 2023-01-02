require 'rails_helper'

RSpec.describe 'studios index' do
  before(:each) do
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

  it 'displays all studios' do
    visit '/studios'

    expect(page).to have_content('Universal Studios')
    expect(page).to have_content('Paramount Pictures')
    expect(page).to have_content('Warner Brothers Studios')
    expect(page).to have_content('Hollywood')
    expect(page).to have_content('Dana Point')
    expect(page).to have_content('Inglewood')
  end

  it 'displays all movies for each studio' do
    visit '/studios'

    within('#Universal Studios') do
      expect(page).to have_content('Toy Story')
      expect(page).to have_content('Monty Python and the Holy Grail')
      expect(page).to have_content('Airplane!')
      expect(page).to have_content('1995')
      expect(page).to have_content('comedy')
      expect(page).to_not have_content('Star Wars')
    end

    within('#Paramount Pictures') do
      expect(page).to have_content('Star Wars')
      expect(page).to have_content('The Italian Job')
      expect(page).to have_content('crime')
      expect(page).to have_content('1977')
      expect(page).to_not have_content('comedy')
      expect(page).to_not have_content('Toy Story')
    end

    within('#Universal Studios') do
      expect(page).to_not have_content('Toy Story')
      expect(page).to_not have_content('Monty Python and the Holy Grail')
      expect(page).to_not have_content('Airplane!')
      expect(page).to_not have_content('1995')
      expect(page).to_not have_content('comedy')
      expect(page).to_not have_content('Star Wars')
    end
  end
end