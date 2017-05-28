require './models/bird'

# Bird's routes
class BirdsRoute < Sinatra::Application
  # set json content type
  before do
    content_type :json
  end

  # GET #index : fetch all visible birds
  get '/birds' do
    visible_birds = Bird.visible_birds
    serialized_visible_birds = visible_birds.map do |visible_birds|
      BirdSerializer.new(visible_birds)
    end.to_json
    status 200
    body serialized_visible_birds
  end

  # POST #create : create bird
  post '/birds' do
    begin
      bird = Bird.new(json_params)
    rescue Mongoid::Errors::InvalidValue
      status 400 and return
    end
    status bird.save ? 201 : 400
    body BirdSerializer.new(bird).to_json
  end

  # GET #show : fetch particular bird's details
  get '/birds/:id' do
    begin
      bird = Bird.find_by(_id: params[:id])
      status 200
      body BirdSerializer.new(bird).to_json
    rescue Mongoid::Errors::DocumentNotFound
      status 404
    end
  end

  # DELETE #destroy : delete a specific bird
  delete '/birds/:id' do
    begin
      bird = Bird.find_by(_id: params[:id])
      if bird.destroy
        status 200
        body BirdSerializer.new(bird).to_json
      else
        status 409
      end
    rescue Mongoid::Errors::DocumentNotFound
      status 404
    rescue Mongoid::Errors::DocumentNotDestroyed
      status 409
    end
  end

  private
    # validate params
    def json_params
      begin
        JSON.parse(request.body.read)
      rescue
        halt 400, { message: 'Invalid JSON' }.to_json
      end
    end
end
