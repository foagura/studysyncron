module MarkdownHelper
  require 'rouge/plugins/redcarpet'

  class CustomRender < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  def markdown(text)
    render_options = {
      filter_html:         true, # ユーザーが入力したhtmlを出力しない
      hard_wrap:           true, # 改行をhtmlの<br>に置き換え
      space_after_headers: true,  # ヘッダー記号(#)と文字の間にスペース必要
      link_attributes: { rel: 'nofollow', taget: '_blank' },
      fenced_code_blocks: true
    }

    options = {
      no_intra_emphasis: true,
      tables: true,
      autolink: true,
      lax_spacing: true,
      quote: true
    }

    renderer = CustomRender.new(render_options)
    markdown = Redcarpet::Markdown.new(renderer, options)
    markdown.render(text).html_safe
  end
end