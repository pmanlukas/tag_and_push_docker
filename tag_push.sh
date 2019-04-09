original_image="app-iconmon-v1.fhm.de:5000/nvidia/cuda"
target_reg="artifacts.core.pke.fhm.de/dt-docker-public-local/"
minimum_version="0.0"
grep_filter=""


# Download all images
docker pull $original_image --all-tags

# Get all images published after $minimum_version
# format output to be: 
#   docker tag ORIGINAL_IMAGE_NAME:VERSION TARGET_IMAGE_NAME:VERSION |
#   docker push TARGET_IMAGE_NAME:VERSION
# then filter the result, removing any entries containing words defined on $grep_filter (i.e. rc, beta, alpha, etc)
# finally, execute those as commands
docker images $original_image \
  --filter "since=$original_image:$minimum_version" 
  #--format "docker tag {{.Repository}}:{{.Tag}} $target_reg/{{.Repository}}:{{.Tag}} | docker push $target_reg/{{.Repository}}:{{.Tag}}" | 
  --format "docker tag {{.Repository}}:{{.Tag}} $target_reg/{{.Repository}}:{{.Tag}}"
  grep -vE $grep_filter | 
  bash
 