module MarkdownHelper
  require 'redcarpet/render_strip'

  def markdown(text)
    options = {
      filter_html: true,
      hard_wrap: true,
      link_attributes: {
        rel: 'nofollow',
        target: "_blank",
      },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink: true,
      superscript: true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

  def strip_markdown(text)
    renderer = Redcarpet::Render::StripDown
    markdown = Redcarpet::Markdown.new(renderer)

    markdown.render(text)
  end
end
