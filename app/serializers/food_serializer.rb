class FoodSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  
  attributes(
    :id,
    :name,
    :description,
    :price,
    :pictures,
    :ratings,
    :ingredients,
    :cook,
  )

  belongs_to :cook, class_name: "User", foreign_key:"user_id"
  has_many :schedules
  has_many :ingredients
  
  class ScheduleSerializer < ActiveModel::Serializer
    attributes :id, :weekday, :quantity
  end

  class IngredientSerializer < ActiveModel::Serializer
    attributes(:id, :name)
  end
  
  class UserSerializer < ActiveModel::Serializer
    include Rails.application.routes.url_helpers

    attributes(
      :id,
      :first_name,
      :last_name,
      :full_name,
      :phone_number,
      :email,
      :address,
      :role,
      :avatar,
      :latitude,
      :longitude,
    )
    
    def avatar
      attachment = object.avatar_attachment
      if attachment.present?
        {
          id: attachment.id,
          name: attachment.name,
          content_type: attachment.blob.content_type,
          filename: attachment.blob.filename.to_s,
          url: rails_blob_url(attachment)
        }
      else
        attachment = nil
      end
    end
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
