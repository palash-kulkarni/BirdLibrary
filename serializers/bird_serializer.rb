# BirdSerializer is a class which is serializing bird object into particular
# JSON format.
# This can be used to customize JSON
class BirdSerializer
  def initialize(bird)
    @bird = bird
  end

  def as_json(*)
    bird = {
      id: @bird.id,
      name: @bird.name,
      family: @bird.family,
      continents: @bird.continents,
      added: @bird.added,
      visible: @bird.visible
    }
    bird[:errors] = @bird.errors if @bird.errors.any?
    bird
  end
end
