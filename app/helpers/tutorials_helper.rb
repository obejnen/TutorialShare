module TutorialsHelper
    VIDEO_HEIGHT = 450
    VIDEO_WIDTH = 800
    def tag_cloud(tags, classes)
        max = tags.sort_by(&:count).last
        tags.each do |tag|
          index = tag.count.to_f / max.count * (classes.size-1)
          yield(tag, classes[index.round])
        end
    end

    def format_page(text)
        text = remove_tags(text)
        text = to_markdown(text)
        parse_links(text)
    end

    def to_markdown(text)
        Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(render_options = {}), extensions = {}).render(text)
    end

    def remove_tags(text)
    scrubber = Rails::Html::PermitScrubber.new
    scrubber.tags = ['img']
    Loofah.fragment(text).scrub!(scrubber).to_s
    end

    def parse_links(text)
        while !youtube_link(text).nil?
            link = youtube_link(text).to_s
            id = get_youtube_id(link)
            text = text.sub(link, "<iframe width='#{VIDEO_WIDTH}' height='#{VIDEO_HEIGHT}' src='https://www.youtube.com/embed/#{get_youtube_id(link)}'></iframe>")
        end
        text
    end
    
    def youtube_link(source_url)
        regex = /((?:https|http):\/\/\w{0,3}.youtube+\.\w{2,3}\/watch\?v=[\w-]{11})/
        regex.match(source_url)
    end
    
    def get_youtube_id(url)
        id = ''
        url = url.gsub(/(>|<)/i,'').split(/(vi\/|v=|\/v\/|youtu\.be\/|\/embed\/)/)
        if url[2] != nil
          id = url[2].split(/[^0-9a-z_\-]/i)
          id = id[0];
        else
          id = url;
        end
        id
    end
end