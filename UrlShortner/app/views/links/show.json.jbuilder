json.extract! @link, :shortcode, :source_link
json.shorturl "#{root_url}u/#{@link.shortcode}"
json.url link_url(@link, format: :json)
