module TutorialsHelper
    def tag_cloud(tags, classes)
        max = tags.sort_by(&:count).last
        tags.each do |tag|
          index = tag.count.to_f / max.count * (classes.size-1)
          yield(tag, classes[index.round])
        end
    end

    def to_markdown(text)
        Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(render_options = {}), extensions = {}).render(text)
    end

    def remove_tags(text)
    scrubber = Rails::Html::PermitScrubber.new
    scrubber.tags = ['img']
    Loofah.fragment(text).scrub!(scrubber).to_s
    end

    def youtube_embed(youtube_url)
        if youtube_url[/youtu\.be\/([^\?]*)/]
          youtube_id = $1
        else
          # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
          youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
          youtube_id = $5
        end
      
        %Q{<iframe title="YouTube video player" width="640" height="390" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
    end
end