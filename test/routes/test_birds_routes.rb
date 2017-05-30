require_relative '../test_app'

# Bird Routes test cases
class BirdsRoutesTest < AppTest
  # fetch all birds, should return 200
  def test_it_fetch_birds
    get '/birds'
    assert last_response.ok?
  end

  # fetch all birds, should have only visible birds in response
  def test_only_visible_birds
    get '/birds'
    assert last_response.ok?
    json_data = JSON last_response.body
    assert json_data.select{ |data| true unless data['visible'] }.blank?
  end

  # while creating a bird, check presence validations
  def test_presence_validations
    data = { 'added' => '1993-03-15' }
    post '/birds', data.to_json
    assert last_response.status.eql?(400)
    json_data = JSON last_response.body
    assert json_data['errors'].present?
  end

  # while creating a bird, check 'added' format
  def test_added_invalid_format
    data = { 'name' => 'Wandering albatross', 'family' => 'Diomedeidae',
             'continents' => ['Antarctica'], 'added' => '1993-13-15' }
    post '/birds', data.to_json
    assert last_response.status.eql?(400)
    json_data = JSON last_response.body
    assert json_data['errors'].present?
  end

  # while creating a bird, check if continents have invalid type
  def test_continents_invalid_format
    data = { 'name' => 'Wandering albatross', 'family' => 'Diomedeidae',
             'continents' => 'Antarctica', 'added' => '1993-03-15' }
    post '/birds', data.to_json
    assert last_response.status.eql?(400)
  end

  # while creating a bird, check if continents have duplicate values
  def test_duplicate_continents
    data = { 'name' => 'Wandering albatross', 'family' => 'Diomedeidae',
             'continents' => ['Antarctica', 'Antarctica'], 'added' => '1993-03-15' }
    post '/birds', data.to_json
    assert last_response.status.eql?(400)
    json_data = JSON last_response.body
    assert json_data['errors'].present?
  end

  # valid bird creation
  def test_valid_creation
    data = { 'name' => 'Wandering albatross', 'family' => 'Diomedeidae',
             'continents' => ['Antarctica'], 'added' => '1993-03-15' }
    post '/birds', data.to_json
    assert last_response.status.eql?(201)
    json_data = JSON last_response.body
    assert json_data['errors'].blank?
  end

  # while show bird details by id and if it exists in database
  def test_valid_fetch
    test_valid_creation
    get "/birds/#{Bird.last.id}"
    assert last_response.status.eql?(200)
    json_data = JSON last_response.body
    assert json_data.present?
  end

  # while showing bird details by id and if it doesn't exist in database
  def test_invalid_fetch
    get '/birds/1'
    assert last_response.status.eql?(404)
  end

  # while deleting bird by id and if it exists in database
  def test_valid_destroy
    test_valid_creation
    delete "/birds/#{Bird.last.id}"
    assert last_response.status.eql?(200)
    json_data = JSON last_response.body
    assert json_data.present?
  end

  # while deleting bird by id and if it doesn't exists in database
  def test_not_found_destroy
    delete '/birds/1'
    assert last_response.status.eql?(404)
  end
end
