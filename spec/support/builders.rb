module Builders
  def build_target_group(name, opts)
    TargetGroup.create(
      name: name,
      external_id: "#{name}-external",
      parent: opts[:parent],
      secret_code: "#{name}-secret",
      country: Country.last,
      panel_provider: opts[:panel_provider]
    )
  end
end

RSpec.configure do |config|
  config.include Builders
end
