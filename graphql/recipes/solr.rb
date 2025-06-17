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
subOrganizationID = json_data["subOrganizationID"]
enviromentID = json_data["enviromentID"]
graphID = json_data["graphID"]
version = json_data["version"]

Chef::Log.debug("installDirectory: #{installDirectory.inspect}")
Chef::Log.debug("rootDirectory: #{rootDirectory.inspect}")
Chef::Log.debug("projectName: #{projectName.inspect}")
Chef::Log.debug("enviromentID: #{enviromentID.inspect}")
Chef::Log.debug("graphID: #{graphID.inspect}")


# targetDirectory = installDirectory + rootDirectory + projectName + "/" + enviromentID + "/" + graphID + "/scripts"

targetDirectory = "#{installDirectory}/#{rootDirectory}/#{projectName}/#{enviromentID}/#{graphID}/scripts"

user 'ravi.dhyani' do
    comment 'User for owning the directory'
    uid '1001' # Optional, specify the user ID if necessary
    gid 'users' # Optional, specify the group ID or group name if necessary
    home '/home/ravi.dhyani'
    shell '/bin/bash'
    manage_home true # Creates the home directory if it doesn't exist
    action :create
  end

=begin
directory installDirectory + rootDirectory + projectName + "/" + enviromentID + "/" + graphID do
  owner 'ravi.dhyani'
 # group 'group_name'
  mode '0755'
  recursive true
  action :create
end
=end

directory "#{installDirectory}/#{rootDirectory}/#{projectName}/#{enviromentID}/#{graphID}/kubernates" do
  owner 'ravi.dhyani'
  mode '0755'
  recursive true
  action :create
end

remote_directory targetDirectory  do
  source 'scripts'
  owner 'root'    # Set the owner of the directory
  group 'root'    # Set the group of the directory
  mode '0755'     # Set the permissions of the directory
  recursive true  # Copy files and subdirectories recursively
  action :create  # Ensure the directory is created with the specified settings
end

# Extract table names from the graph
tables = graph.map { |table| table.keys.first }

template installDirectory + rootDirectory + projectName + "/" + enviromentID + "/" + graphID + "/Dockerfile" do
  source "solr/Dockerfile.erb"
  variables(
    tables: tables
  )
  action :create
end

template "#{installDirectory}/#{rootDirectory}/#{projectName}/#{enviromentID}/#{graphID}/kubernates/solr-deployment.yaml" do
  source "kubernates/solr-deployment.yaml.erb"
  variables(
    project_name: json_data["projectName"],
    sub_organization_id: json_data["subOrganizationID"],
    enviroment_id: json_data["enviromentID"],
    graph_id: json_data["graphID"],
    version: json_data["version"]
  )
  action :create
end

template "#{installDirectory}/#{rootDirectory}/#{projectName}/#{enviromentID}/#{graphID}/kubernates/solr-ingress.yaml" do
  source "kubernates/solr-ingress.yaml.erb"
  variables(
    tables: tables
  )
  action :create
end

template "#{installDirectory}/#{rootDirectory}/#{projectName}/#{enviromentID}/#{graphID}/kubernates/solr-service.yaml" do
  source "kubernates/solr-service.yaml.erb"
  variables(
    tables: tables
  )
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
  
directory "#{installDirectory}#{rootDirectory}#{projectName}/#{enviromentID}/#{graphID}/#{key}" do
    owner 'ravi.dhyani'
   # group 'group_name'
    mode '0755'
    recursive true
    action :create
end

directory "#{installDirectory}#{rootDirectory}#{projectName}/#{enviromentID}/#{graphID}/#{key}/conf" do
    owner 'ravi.dhyani'
   # group 'group_name'
    mode '0755'
    recursive true
    action :create
end

directory "#{installDirectory}#{rootDirectory}#{projectName}/#{enviromentID}/#{graphID}/#{key}/data" do
    owner 'ravi.dhyani'
   # group 'group_name'
    mode '0755'
    recursive true
    action :create
end


template installDirectory + rootDirectory + projectName +"/#{enviromentID}"+"/#{graphID}"+"/#{key}/core.properties" do
    source 'solr/core.properties.erb' # Assuming you have a template file named controller_template.erb
    variables(
    table_name: "#{key}",
    fields: value['fields'],
    relations: value['relations']
    )
    action :create # Use :create_if_missing if you only want to create the file if it doesn't exist
end

template installDirectory + rootDirectory+ projectName +"/#{enviromentID}"+"/#{graphID}"+"/#{key}/solrconfig.xml" do
    source 'solr/solrconfig.xml.erb' # Assuming you have a template file named controller_template.erb
    variables(
    table_name: "#{key}",
    fields: value['fields'],
    relations: value['relations']
    )
    action :create # Use :create_if_missing if you only want to create the file if it doesn't exist
end


template installDirectory + rootDirectory + projectName +"/#{enviromentID}"+"/#{graphID}"+"/#{key}/schema.xml" do
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
