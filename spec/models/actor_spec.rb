require 'rails_helper'

RSpec.describe Actor do
  describe 'relationships' do
    it {should have_many :actor_movies }
    it {should have_many :movies }
  end
end