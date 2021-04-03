class BirdsController < ApplicationController
  def index
    birds = Bird.all
    # render json: birds

    # render json: birds, only: [:id, :name, :species]
    # render json: birds.to_json(only: [:id, :name, :species])
        # for an array of hashes, don't use slice (only for a single hash of birld)
            # use only: option directly after listing an object we want to render to JSON:
  
    # render json: birds, except: [:created_at, :updated_at]    
        # except option, not listing every key we want to include, opposite from the only: option ^^
  render json: birds.to_json(except: [:created_at, :updated_at])
          # to_json method, the only and except keywords are actually parameters of the to_json method
          # As customization becomes more complicated, writing in sometimes help to clarify what is happening.
  end

  def show 
    bird = Bird.find_by(id: params[:id])
          # When using find_by, if the record is not found, nil is returned.
          #       As we have it set up, if params[:id] does not match a valid id, nil will be assigned to the bird variable.

          # As nil is a false-y value in Ruby, this gives us the ability to write our own error 
          #       messaging in the event that a request is made for a record that doesn't exist:
    
          if bird
            render json: { id: bird.id, name: bird.name, species: bird.species }
          else
            render json: { message: 'Bird not found' }
          end


    
    # render json: bird
    # render json: {id: bird.id, name: bird.name, species: bird.species }
        # hashes of 3 keys that are manually assigned with attributes of bird
        # visit a specific bird's endpoint: http://localhost:3000/birds/3
        #     return: id, name and species
    # render json: bird.slice(:id, :name, :species)
        # Ruby's built-in slice method
        # Rather than having to spell out each key, 
            # the Hash slice method (Links to an external site.) 
            # returns a new hash with only the keys that are passed into slice. 
            # In this case, :id, :name, and :species were passed in, 
            # so created_at and updated_at get left out, just like before.
  end


  # Reminder: No need for instance variables anymore, since we're immediately > 
  # rendering birds and bird to JSON and are not going to be using ERB.
  # Now, visiting http://localhost:3000/birds will produce an array of Bird objects, 
  # but http://localhost:3000/birds/2 will produce just one:
end