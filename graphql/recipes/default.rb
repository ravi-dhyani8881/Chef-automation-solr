#
# Cookbook:: graphql
# Recipe:: default
#
# Copyright:: 2024, The Authors, All Rights Reserved.

# Read the contents of the JSON file as a string
#json_string = File.read('/Users/ravi.dhyani/Desktop/mine/git/chef/file.json')
json_string = File.read('/var/chef/cookbooks/graphql/file.json')

# Parse the JSON string into a Ruby hash
json_data = JSON.parse(json_string)

# Access the value associated with the "cities" key
graph = json_data["tables"]

projectName = json_data["projectName"]

installDirectory = "/var/chef/output/"


#file_names = JSON.parse(File.read('/Users/ravi.dhyani/Desktop/mine/git/chef/file_names.json'))
#file_names = JSON.parse(File.read('/Users/ravi.dhyani/Desktop/mine/git/chef/file.json'))

user 'ravi.dhyani' do
  comment 'User for owning the directory'
  uid '1001' # Optional, specify the user ID if necessary
  gid 'users' # Optional, specify the group ID or group name if necessary
  home '/home/ravi.dhyani'
  shell '/bin/bash'
  manage_home true # Creates the home directory if it doesn't exist
  action :create
end

directory installDirectory + projectName do
  owner 'ravi.dhyani'
 # group 'group_name'
  mode '0755'
  recursive true
  action :create
end

# recipe.rb

# Assuming @name is defined elsewhere in the recipe or attributes
template installDirectory + projectName+"/pom.xml" do
  source 'pom.xml.erb'
  variables(
    projectName: projectName
  )
  owner 'ravi.dhyani'
  #group 'ravi.dhyani'
  mode '0644'
  action :create
end

directory installDirectory + projectName+ "/src/main/java" do
  owner 'ravi.dhyani'
 # group 'group_name'
  mode '0755'
  recursive true
  action :create
end

directory installDirectory + projectName+ "/src/main/java/com/spring/graph/Model" do
  owner 'ravi.dhyani'
 # group 'group_name'
  mode '0755'
  recursive true
  action :create
end

=begin
# Iterate over each file name in the array
file_names.each do |file_name|
  # Construct the file path
  file_path = "/Users/ravi.dhyani/Desktop/mine/git/chef/project2/src/main/java/com/spring/graph/Model/Records#{file_name}.java"

  # Create or update the file with content from a template
  template file_path do
    source 'model_template.erb' # Assuming you have a template file named controller_template.erb
    variables(
      file_name: file_name
    )
    action :create # Use :create_if_missing if you only want to create the file if it doesn't exist
  end
end
=end

directory installDirectory + projectName+ "/src/main/java/com/spring/graph" do
  owner 'ravi.dhyani'
 # group 'group_name'
  mode '0755'
  recursive true
  action :create
end

directory installDirectory + projectName+ "/src/main/java/com/spring/graph/Graphql" do
  owner 'ravi.dhyani'
 # group 'group_name'
  mode '0755'
  recursive true
  action :create
end

template installDirectory + projectName+ "/src/main/java/com/spring/graph/Graphql/GraphqlApplicationMain.java" do
  source 'GraphqlApplicationMain.java.erb'
  variables(
    name: 'ravi.dhyani'
  )
  owner 'ravi.dhyani'
  #group 'ravi.dhyani'
  mode '0644'
  action :create
end

directory installDirectory + projectName+ "/src/main/java/com/spring/graph/controller" do
  owner 'ravi.dhyani'
 # group 'group_name'
  mode '0755'
  recursive true
  action :create
end


directory installDirectory + projectName+ "/src/main/java/com/spring/graph/QueryResolver" do
  owner 'ravi.dhyani'
 # group 'group_name'
  mode '0755'
  recursive true
  action :create
end


template installDirectory + projectName+ "/src/main/java/com/spring/graph/QueryResolver/Advanced.java" do
  source 'Advanced.java.erb'
  variables(
    name: 'ravi.dhyani'
  )
  owner 'ravi.dhyani'
  #group 'ravi.dhyani'
  mode '0644'
  action :create
end

=begin
# Read file_names from JSON file
file_names = JSON.parse(File.read('/Users/ravi.dhyani/Desktop/mine/git/chef/file_names.json'))

# Create template resource using file_names
template '/Users/ravi.dhyani/Desktop/mine/git/chef/project2/src/main/java/com/spring/graph/QueryResolver/GenericQueryResolver.java' do
  source 'GenericQueryResolver.java.erb'
  variables(
    file_names: file_names
  )
  action :create
end


# Iterate over each file name in the array
file_names.each do |file_name|
  # Construct the file path
  file_path = "/Users/ravi.dhyani/Desktop/mine/git/chef/project2/src/main/java/com/spring/graph/QueryResolver/#{file_name}ResponseTemplate.java"

  # Create or update the file with content from a template
  template file_path do
    source 'response_template.erb' # Assuming you have a template file named controller_template.erb
    variables(
      file_name: file_name
    )
    action :create # Use :create_if_missing if you only want to create the file if it doesn't exist
  end
end




# Iterate over each file name in the array
file_names.each do |file_name|
  # Construct the file path
  file_path = "/Users/ravi.dhyani/Desktop/mine/git/chef/project2/src/main/java/com/spring/graph/controller/#{file_name}Controller.java"
  # Create or update the file with content from a template
  template file_path do
    source 'controller_template.erb' # Assuming you have a template file named controller_template.erb
    variables(
      file_name: file_name
    )
    action :create # Use :create_if_missing if you only want to create the file if it doesn't exist
  end
end

=end

directory installDirectory + projectName+ "/src/main/java/com/spring/graph/utils" do
  owner 'ravi.dhyani'
 # group 'group_name'
  mode '0755'
  recursive true
  action :create
end


template installDirectory + projectName+ "/src/main/java/com/spring/graph/utils/QueryUtils.java" do
  source 'QueryUtils.java.erb'
  variables(
    name: 'ravi.dhyani'
  )
  owner 'ravi.dhyani'
  #group 'ravi.dhyani'
  mode '0644'
  action :create
end


directory installDirectory + projectName+ "/src/main/resources/graphql/" do
  owner 'ravi.dhyani'
 # group 'group_name'
  mode '0755'
  recursive true
  action :create
end

=begin
# Iterate over each file name in the array
file_names.each do |file_name|
  # Construct the file path
  file_path = "/Users/ravi.dhyani/Desktop/mine/git/chef/project2/src/main/resources/graphql/#{file_name}.graphqls"

  # Create or update the file with content from a template
  template file_path do
    source 'standards.graphqls.erb' # Assuming you have a template file named controller_template.erb
    variables(
      file_name: file_name
    )
    action :create # Use :create_if_missing if you only want to create the file if it doesn't exist
  end
end
=end

template installDirectory + projectName+ "/src/main/resources/graphql/common.graphqls" do
  source 'common.graphqls.erb'
  variables(
    name: 'ravi.dhyani'
  )
  owner 'ravi.dhyani'
  #group 'ravi.dhyani'
  mode '0644'
  action :create
end

template installDirectory + projectName+ "/src/main/resources/application.properties" do
  source 'application.properties.erb'
  variables(
    name: 'ravi.dhyani'
  )
  owner 'ravi.dhyani'
  #group 'ravi.dhyani'
  mode '0644'
  action :create
end

directory installDirectory + projectName+ "/src/main/java/com/spring/graph/error" do
  owner 'ravi.dhyani'
 # group 'group_name'
  mode '0755'
  recursive true
  action :create
end

template installDirectory + projectName+ "/src/main/resources/application.properties" do
  source 'application.properties.erb'
  variables(
    name: 'ravi.dhyani'
  )
  owner 'ravi.dhyani'
  #group 'ravi.dhyani'
  mode '0644'
  action :create
end

template installDirectory + projectName+ "/src/main/java/com/spring/graph/QueryResolver/GenericQueryResolver.java" do
  source 'GenericQueryResolver.java.erb'
  variables(
    graph: json_data
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

        template installDirectory + projectName+ "/src/main/resources/graphql/#{key}.graphqls" do
          source 'standards.graphqls.erb' # Assuming you have a template file named controller_template.erb
          variables(
            table_name: "#{key}",
            fields: value['fields'],
            relations: value['relations']
          )
          action :create # Use :create_if_missing if you only want to create the file if it doesn't exist
        end

        file_path = installDirectory + projectName+ "/src/main/java/com/spring/graph/controller/#{key}Controller.java"
        # Create or update the file with content from a template
        template file_path do
          source 'controller_template.erb' # Assuming you have a template file named controller_template.erb
          variables(
            file_name: "#{key}",
            relations: value['relations']
          )
          action :create # Use :create_if_missing if you only want to create the file if it doesn't exist
        end
        
        file_path = installDirectory + projectName+"/src/main/java/com/spring/graph/QueryResolver/#{key}ResponseTemplate.java"
        # Create or update the file with content from a template
        template file_path do
          source 'response_template.erb' # Assuming you have a template file named controller_template.erb
          variables(
            file_name: "#{key}"
          )
          action :create # Use :create_if_missing if you only want to create the file if it doesn't exist
        end

        file_path = installDirectory + projectName+ "/src/main/java/com/spring/graph/Model/Records#{key}.java"

        # Create or update the file with content from a template
        template file_path do
          source 'model_template.erb' # Assuming you have a template file named controller_template.erb
          variables(
            file_name: "#{key}"
          )
          action :create # Use :create_if_missing if you only want to create the file if it doesn't exist
        end
      end
    end
  end
end
