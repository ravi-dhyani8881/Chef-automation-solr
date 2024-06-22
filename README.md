# Chef-automation-graphiql
Chef-automation-graph

chef-solo -c solo.rb -j web.json -l info

docker build -t my-chef-solo-image .

docker run -it --rm my-chef-solo-image /bin/bash

docker run --rm -e GITHUB_TOKEN=your_github_token my-chef-solo-image

docker run --rm -e GITHUB_TOKEN=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 my-chef-solo-image

docker run --rm -v /workspaces/Chef-automation-graphiql/file.json:/var/chef/cookbooks/graphql/file.json -e GITHUB_TOKEN=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 my-chef-solo-image
