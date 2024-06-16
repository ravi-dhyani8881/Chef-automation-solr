# Chef-automation-graphiql
Chef-automation-graph

chef-solo -c solo.rb -j web.json -l info

docker build -t my-chef-solo-image .

docker run -it --rm my-chef-solo-image /bin/bash