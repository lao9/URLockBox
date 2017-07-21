class Link < ActiveRecord::Base
  belongs_to :user

  def self.add_new_link(params)
    create(params)
    {message: "Link successfully created.", status: 200}
  end

end
