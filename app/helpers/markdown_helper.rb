module MarkdownHelper
  require 'rouge/plugins/redcarpet'

  class CustomRender < Redcarpet::Render::Base
    include Rouge::Plugins::Redcarpet
  end

  def markdown(text)
    options = {
      no_intra_emphasis: true,
      tables: true,
      fenced_code_blocks: true,
      autolink: true,
      lax_spacing: true,
      space_after_headers: true,
      hard_wrap: true,
      link_attributes: { rel: 'nofollow', taget: '_blank' },
      quote: true
    }

    renderer = CustomRender.new
    markdown = Redcarpet::Markdown.new(renderer, options)
    markdown.render(text).html_safe
  end
end