class TurboRailsGem::Streams::TagBuilder
  def initialize(view_context)
    @view_context = view_context
    @view_context.formats |= [:html] 
  end

  def replace(target, content = nil, **options, &block)
    action :replace, target, content, **options, &block
  end

  def update(target, content = nil, **options, &block)
    action :update, target, content, **options, &block
  end

  def prepend(target, content = nil, **options, &block)
    action :prepend, target, content, **options, &block
  end

  def remove(target)
    action :remove, target
  end

  private

  def action(action, target, content = nil, **options, &block)
    view_template = render_view_template(target, content, **options, &block) unless action == :remove

    turbo_stream_action_tag(action, target: target, template: view_template)
  end

  def turbo_stream_action_tag(action, target:, template:)
    raise ArgumentError, "A target must be supplied" if target.blank?
    
    target = convert_to_turbo_stream_dom_id(target)
    template_tag = action == :remove ? "" : "<template>#{template}</template>"

    %(<turbo-stream target="#{target}" action="#{action}">#{template_tag}</turbo-stream>).html_safe
  end

  def convert_to_turbo_stream_dom_id(target)
    target.respond_to?(:to_key) ? ActionView::RecordIdentifier.dom_id(target) : target
  end

  def render_view_template(target, content = nil, **options, &block)
    if content
      content.respond_to?(:to_partial_path) ? @view_context.render(partial: content, formats: :html) : content
    elsif block_given?
      @view_context.capture(&block)
    elsif options.any?
      @view_context.render(**options, formats: :html)
    else
      @view_context.render(partial: target, formats: :html)
    end
  end
end