
class ImagePreviewInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    resize = options.delete(:size) || '350x100>'
    size = resize.sub(/\D$/,'')
    keys = options.delete(:attribute_keys)
    name = attribute_name.to_s
    attribute_keys = @builder.object.attributes.keys.inject([]) do |array, x|
      n, a = x.split("_")
      n == name && a.present? ? array << a : array
    end

    template.render("simple_dragonfly_preview/image/form",
      f: @builder,
      attribute_name: name,
      retained_id: ([field_name, "retained", name]).join("_"),
      image_id: ([field_name, name, "preview"]).join("_"),
      size: size,
      resize: resize,
      attribute_keys: attribute_keys.join(","))
  end

  def field_name
    object_name.split(/\[|\]/).reject(&:empty?).join('_')
  end
end


