class NullArtist
  def name
  end

  def images
    [OpenStruct.new(url: '')]
  end
end
