def rand_country
  @countries[rand(@countries.size)]
end

def build_tree(tree, opts={})
  if tree.is_a?(Hash)
    tree.each do |name, subtree|
      parent = build_target_group(name, opts)
      build_tree(subtree, opts.merge(parent: parent))
    end
  elsif tree
    build_target_group(tree, opts)
  end
end

def build_target_group(name, opts)
  TargetGroup.create(
    name: name,
    external_id: name,
    parent: opts[:parent],
    secret_code: name,
    country: rand_country,
    panel_provider: opts[:panel_provider]
  )
end

panel_provider_1 = PanelProvider.create!(code: 'alpha')
panel_provider_2 = PanelProvider.create!(code: 'beta')
panel_provider_3 = PanelProvider.create!(code: 'gamma')

country_1 = Country.create!(country_code: 'AUS', panel_provider: panel_provider_1)
country_2 = Country.create!(country_code: 'ENG', panel_provider: panel_provider_2)
country_3 = Country.create!(country_code: 'US', panel_provider: panel_provider_3)
@countries = [country_1, country_2, country_3]

Location.create!(secret_code: 'AL', external_id: 'AL', name: "Alabama, Montgomery", country: rand_country)
Location.create!(secret_code: 'AK', external_id: 'AK', name: "Alaska,  Juneau", country: rand_country)
Location.create!(secret_code: 'AZ', external_id: 'AZ', name: "Arizona, Phoenix", country: rand_country)
Location.create!(secret_code: 'AR', external_id: 'AR', name: "Arkansas,  Little Rock", country: rand_country)
Location.create!(secret_code: 'CA', external_id: 'CA', name: "California,  Sacramento", country: rand_country)
Location.create!(secret_code: 'CO', external_id: 'CO', name: "Colorado,  Denver", country: rand_country)
Location.create!(secret_code: 'CT', external_id: 'CT', name: "Connecticut, Hartford", country: rand_country)
Location.create!(secret_code: 'DE', external_id: 'DE', name: "Delaware,  Dover", country: rand_country)
Location.create!(secret_code: 'FL', external_id: 'FL', name: "Florida, Tallahassee", country: rand_country)
Location.create!(secret_code: 'GA', external_id: 'GA', name: "Georgia, Atlanta", country: rand_country)
Location.create!(secret_code: 'HI', external_id: 'HI', name: "Hawaii,  Honolulu", country: rand_country)
Location.create!(secret_code: 'ID', external_id: 'ID', name: "Idaho, Boise", country: rand_country)
Location.create!(secret_code: 'IL', external_id: 'IL', name: "Illinois,  Springfield", country: rand_country)
Location.create!(secret_code: 'IN', external_id: 'IN', name: "Indiana, Indianapolis", country: rand_country)
Location.create!(secret_code: 'IA', external_id: 'IA', name: "Iowa,  Des Moines", country: rand_country)
Location.create!(secret_code: 'KS', external_id: 'KS', name: "Kansas,  Topeka", country: rand_country)
Location.create!(secret_code: 'KY', external_id: 'KY', name: "Kentucky,  Frankfort", country: rand_country)
Location.create!(secret_code: 'LA', external_id: 'LA', name: "Louisiana, Baton Rouge", country: rand_country)
Location.create!(secret_code: 'ME', external_id: 'ME', name: "Maine, Augusta", country: rand_country)
Location.create!(secret_code: 'MD', external_id: 'MD', name: "Maryland,  Annapolis", country: rand_country)

LocationGroup.create(name: "Small", country: rand_country, panel_provider: panel_provider_1)
LocationGroup.create(name: "Medium", country: rand_country, panel_provider: panel_provider_1)
LocationGroup.create(name: "Large", country: rand_country, panel_provider: panel_provider_1)
LocationGroup.create(name: "Huge", country: rand_country, panel_provider: panel_provider_2)

build_tree({apple: {banana: {orange: :grape}}, strawberry: :plum}, panel_provider: panel_provider_1)
build_tree({cat: {dog: {mouse: :girafe, hamster: nil}}}, panel_provider: panel_provider_2)
build_tree({sea: {ocean: {puddle: {cannal: :dam}}}, river: {stream: {lake: :waterhole}}}, panel_provider: panel_provider_1)
build_tree({one: {two: {three: {four: :five}}}}, panel_provider: panel_provider_2)
