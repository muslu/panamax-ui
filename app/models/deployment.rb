class Deployment < BaseResource
  self.prefix = '/deployment_targets/:deployment_target_id/'

  has_one :override

  schema do
    integer :id
    string :resource_id
    string :resource_type
    string :name
  end

  def redeploy
    response = self.post(:redeploy)
    Deployment.new(JSON.parse(response.body))
  end

  def to_param
    self.id
  end

  def display_name
    self.name || 'Unnamed Deployment'
  end

  def as_json(options={})
    super
      .merge(
        'display_name' => display_name
      )
  end

end
