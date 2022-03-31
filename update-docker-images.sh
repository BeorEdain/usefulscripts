#! /bin/bash -e

images=$(docker images | grep -v REPOSITORY| awk '{print $1}'| xargs -L1)
image_tags=$(docker images | grep -v REPOSITORY| awk '{print $2}'| xargs -L1)

image_array=()

for image in $images
do
    image_array+=($image)
done

image_tag_array=()

i=0
for tag in $image_tags
do
    if [ $tag = "<none>" ]
    then
        docker image rm "${image_array[i]}:$tag"
        echo "Removing ${image_array[i]}:$tag"
    fi
    image_tag_array+=("${image_array[i]}:$tag")
    i=$i+1
done

for image in ${image_tag_array[@]}
do
    echo "Pulling $image"
    docker pull $image
    echo "--------------------------------------------------------------------"
done

docker image prune -f