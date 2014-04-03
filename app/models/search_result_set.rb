require 'active_model'

class SearchResultSet
  include ActiveModel::Model

  attr_reader :query, :remote_images, :local_images

  def initialize(attributes)
    @query = attributes['q']
    @remote_images = wrap_images(attributes['remote_images'])
    @local_images = wrap_images(attributes['local_images'])
  end

  def self.create_from_response(response)
    attributes = JSON.parse(response)
    self.new(attributes)
  end

  private

  def wrap_images(images)
    (images || []).map do |image_attributes|
      Image.new(image_attributes)
    end
  end
end