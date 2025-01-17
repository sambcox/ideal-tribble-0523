require 'rails_helper'

RSpec.describe 'movies show' do
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

  it 'displays all movie information' do
    visit "/movies/#{@toy.id}"

    expect(page).to have_content('Toy Story')
    expect(page).to have_content('1995')
    expect(page).to have_content('animation')
    expect(page).to_not have_content('Star Wars')

    visit "/movies/#{@star.id}"

    expect(page).to have_content('Star Wars')
    expect(page).to have_content('1977')
    expect(page).to have_content('sci-fi')
    expect(page).to_not have_content('The Italian Job')
  end

  it 'displays all actors for specific movie' do
    visit "/movies/#{@toy.id}"
    
    expect('Tom Hanks').to appear_before('Meryl Streep')
    expect(page).to_not have_content('Michael Caine')
  end

  it 'displays all actors for specific movie' do
    visit "/movies/#{@toy.id}"
    
    expect(page).to have_content('Average Actor Age: 69')
  end

  it 'allows for the addition of an actor' do
    visit "/movies/#{@toy.id}"

    expect(page).to_not have_content('Leslie Nielsen')

    fill_in('actor_id', with: "#{@leslie.id}")
    click_button('Submit')

    expect(current_path).to eq("/movies/#{@toy.id}")
    expect(page).to have_content('Leslie Nielsen')
  end
end