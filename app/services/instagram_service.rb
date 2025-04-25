class InstagramService
  def self.get_recent_posts(limit = 6)
    return [] unless ENV['INSTAGRAM_ACCESS_TOKEN']

    client = InstagramBasicDisplay::Client.new(
      access_token: ENV['INSTAGRAM_ACCESS_TOKEN']
    )

    begin
      media = client.user_media
      media.first(limit).map do |post|
        {
          id: post['id'],
          url: post['media_url'],
          permalink: post['permalink'],
          thumbnail_url: post['thumbnail_url'] || post['media_url'],
          caption: post['caption']
        }
      end
    rescue => e
      Rails.logger.error "Erro ao buscar posts do Instagram: #{e.message}"
      []
    end
  end
end 