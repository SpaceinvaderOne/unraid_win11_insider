#!/bin/bash
cleanupandmove() {

	if [ ! -e /isos/$isoname ] && [ -e /config/*.ISO ]; then
		echo "I am going to move iso to the isos share"
	    echo "."
	    echo "."
		mv *.ISO /isos/$isoname  
	    rm -r UUPs 
		echo "Ok all done. Image is now in the iso share called " "$isoname"
		
	elif [ ! -e /isos/$isoname ] && [ -e /config/*.iso ]; then
			echo "I am going to move iso to the isos share"
		    echo "."
		    echo "."
			mv *.iso /isos/$isoname  
		    rm -r UUPs 
			echo "Ok all done. Image is now in the iso share called " "$isoname"
	
else
	echo "Media already exists with that name so i will not move iso. Please move manually"
    echo "."
    echo "."
	rm -r UUPs 

fi

}

download() {
	if [ "$version" == "custom" ] ; then
		cd /config/custom/
		sh ./$name && cleanupandmove 
		
	else 
		sh ./downloadwin11.sh && cleanupandmove 

fi
}

# copy working files to appdata bind mount
rsync -avh --exclude-from '/win11/exclude-list.txt' /win11/ /config/ && chmod 777 -R /config 
# change dir to appdata and set perm
cd /config/ && chmod a+x downloadwin11.sh 

# download win11 insiders then move image to isos share
download 
chmod 777 -R /config 
sleep 10
exit


