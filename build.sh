WORKING_DIR=/home/lcamilo/Documents/Projects/docker_containers/hapi-test-server/hapi-fhir/
BUILD_DIR=~/Documents/Projects/luis-camilo.github.io/releases/hapi-fhir/

cd $WORKING_DIR

for tag in $(git tag)
do
    current_tag=tags/$tag
    TARGET_DIR=$BUILD_DIR$tag/

    if [ -d "$TARGET_DIR" ]; then
	echo "Target directory $TARGET_DIR already exists please remove it and try again" 
    else
	
	git checkout -f $current_tag
	mvn clean install -DskipTests=tru

	mkdir -p $TARGET_DIR

	printf "\n Copying built files for version %s into %s \n\n" $tag $TARGET_DIR

	for file in $(ls */target/*.war)
	do
	    DEST_FILE=$(echo $file | sed 's:.*/::' | sed -e 's/\(\.\w\+\)$/-'$tag'\1/g')
	    printf "%2s%s \n" " " $DEST_FILE
	    cp $WORKING_DIR$file $TARGET_DIR$DEST_FILE
	done
    fi
done

