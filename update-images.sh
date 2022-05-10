#!/bin/bash -e

echo "Removing all dangling images..."
docker image prune -f
echo ""
echo "-------------------------------------------------------------------------"

# Get the docker image names
images=$(docker images | grep -v REPOSITORY| awk '{print $1}'| xargs -L1)

# Get the docker image tags
image_tags=$(docker images | grep -v REPOSITORY| awk '{print $2}'| xargs -L1)

# Create a blank array for the image
image_array=()

# Go through each image name and add it to the array
for image in $images
do
    image_array+=($image)
done

# Create a blank array for the image and tag
image_tag_array=()

# Go through the tag array to weed out any with the <none> value and add the tag
# to the correct image
i=0
for tag in $image_tags
do
    image_tag_array+=("${image_array[i]}:$tag")
    i=$i+1
done

# Pull each image. Docker automatically skips the image if it already up to date
for image in ${image_tag_array[@]}
do
    echo "Pulling $image"
    # Try to pull the image with the tag. If it can't find it (in the case of a)
    # custom image), tell the user and skip it.
    if ! docker pull $image;
    then
        echo "Can't pull $image. Skipping."
    fi
    echo ""
    echo "--------------------------------------------------------------------"

done

# Prune any extra images at the end
echo "Removing all dangling images..."
docker image prune -f