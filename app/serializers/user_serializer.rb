class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes(
    :id,
    :first_name,
    :last_name,
    :full_name,
    :role,
    :verified,
    :created_at,
    :updated_at,
    :avatar
  )

  has_many :orders

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
