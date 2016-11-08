# frozen_string_literal: true

# Application helpers
module ApplicationHelper
  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def markdown(text)
    options = {
      # scape any HTML tags. This option has precedence over :no_styles,
      # :no_links, :no_images and :filter_html which means that any existing tag
      # will be escaped instead of being removed.
      escape_html: true
    }
    renderer = Redcarpet::Render::HTML.new(options)

    Redcarpet::Markdown.new(renderer).render(text)
  end
end
