class FoodSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  
  attributes(
    :id,
    :name,
    :description,
    :price,
    :pictures,
    :ratings
  )

  belongs_to :cook
  has_many :schedules

  class ScheduleSerializer < ActiveModel::Serializer
    attributes :id, :weekday, :quantity
  end
  
  class UserSerializer < ActiveModel::Serializer
    attributes(
      :id,
      :first_name,
      :last_name,
      :full_name,
      :email,
      :role
    )
  end

  def pictures
    object.pictures_attachments.includes(:blob).map do |attachment|
      {
        id: attachment.id,
        name: attachment.name,
        content_type: attachment.blob.content_type,
        filename: attachment.blob.filename.to_s,
        url: rails_blob_url(attachment)
      }
    end
  end
end
