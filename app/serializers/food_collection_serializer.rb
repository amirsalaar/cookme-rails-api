class FoodCollectionSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes(
    :id,
    :name,
    :description,
    :price,
    :cook,
    :pictures,
    )

    belongs_to :cook

    class UserSerializer < ActiveModel::Serializer
      attributes(
        :latitude,
        :longitude
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
