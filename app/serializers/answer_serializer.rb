class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :audio_url, :audio_length, :tip
end
