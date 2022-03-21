class ApexLegendsMapSerializer < ActiveModel::Serializer
  attributes :map_type,
    :name,
    :starts_at,
    :ends_at

  def starts_at
    object.starts_at&.iso8601
  end

  def ends_at
    object.ends_at&.iso8601
  end
end
