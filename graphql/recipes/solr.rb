#
# Cookbook:: graphql
# Recipe:: solr
#
# Copyright:: 2024, The Authors, All Rights Reserved.


#installDirectory = "/Users/ravi.dhyani/Desktop/mine/git/chef/"
 installDirectory = "/var/chef/output/"

rootDirectory="gitRepo"

#file_names = JSON.parse(File.read('/Users/ravi.dhyani/Desktop/mine/git/chef/file_names.json'))
#file_names = JSON.parse(File.read('/Users/ravi.dhyani/Desktop/mine/git/chef/file.json'))

#json_string = File.read('/Users/ravi.dhyani/Desktop/mine/git/chef/file.json')
json_string = File.read('/var/chef/cookbooks/graphql/file.json')


# Parse the JSON string into a Ruby hash
json_data = JSON.parse(json_string)

# Access the value associated with the "cities" key
graph = json_data["tables"]

projectName = json_data["projectName"]


user 'ravi.dhyani' do
    comment 'User for owning the directory'
    uid '1001' # Optional, specify the user ID if necessary
    gid 'users' # Optional, specify the group ID or group name if necessary
    home '/home/ravi.dhyani'
    shell '/bin/bash'
    manage_home true # Creates the home directory if it doesn't exist
    action :create
  end

directory installDirectory + rootDirectory do
  owner 'ravi.dhyani'
 # group 'group_name'
  mode '0755'
  recursive true
  action :create
end




json_data['tables'].each do |table|
    # Iterate over keys (Content, Review, like, etc.)
    table.each do |key, value|
      puts "Table: #{key}"
      # Iterate over fields or relations
      if value['fields']
        puts "Fields:"
        value['fields'].each do |field|
          puts "  #{field['name']}: #{field['type']}"
  
directory "#{installDirectory}#{rootDirectory}/#{key}" do
    owner 'ravi.dhyani'
   # group 'group_name'
    mode '0755'
    recursive true
    action :create
end

directory "#{installDirectory}#{rootDirectory}/#{key}/conf" do
    owner 'ravi.dhyani'
   # group 'group_name'
    mode '0755'
    recursive true
    action :create
end

directory "#{installDirectory}#{rootDirectory}/#{key}/data" do
    owner 'ravi.dhyani'
   # group 'group_name'
    mode '0755'
    recursive true
    action :create
end


template installDirectory + rootDirectory+ "/#{key}/core.properties" do
    source 'solr/core.properties.erb' # Assuming you have a template file named controller_template.erb
    variables(
    table_name: "#{key}",
    fields: value['fields'],
    relations: value['relations']
    )
    action :create # Use :create_if_missing if you only want to create the file if it doesn't exist
end
   

template installDirectory + rootDirectory+ "/#{key}/solrconfig.xml" do
    source 'solr/solrconfig.xml.erb' # Assuming you have a template file named controller_template.erb
    variables(
    table_name: "#{key}",
    fields: value['fields'],
    relations: value['relations']
    )
    action :create # Use :create_if_missing if you only want to create the file if it doesn't exist
end


template installDirectory + rootDirectory+ "/#{key}/schema.xml" do
    source 'solr/schema.xml.erb' # Assuming you have a template file named controller_template.erb
    variables(
    table_name: "#{key}",
    fields: value['fields'],
    relations: value['relations']
    )
    action :create # Use :create_if_missing if you only want to create the file if it doesn't exist
end

end
end
end
end
