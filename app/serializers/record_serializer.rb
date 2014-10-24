class RecordSerializer < ActiveModel::Serializer
  attributes :id, :audio_url, :audio_length
end
