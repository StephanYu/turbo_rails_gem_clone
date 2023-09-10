class TurboRailsGem::Streams::TagBuilder
  def initialize(view_context)
    @view_context = view_context
  end

  def replace(target)
    action :replace, target
  end

  private

  def action(action, target)
    view_template = render_view_template(target)

    turbo_stream_action_tag(action, target: target, template: view_template)
  end

  def turbo_stream_action_tag(action, target:, template:)
    raise ArgumentError, "A target must be supplied" if target.blank?
    
    target = convert_to_turbo_stream_dom_id(target)
    template_tag = "<template>#{template}</template>"

    %(<turbo-stream target="#{target}" action="#{action}">#{template_tag}</turbo-stream>).html_safe
  end

  def convert_to_turbo_stream_dom_id(target)
    target.respond_to?(:to_key) ? ActionView::RecordIdentifier.dom_id(target) : target
  end

  def render_view_template(target)
    @view_context.render(partial: target, formats: :html)
  end
end