default: fold1 fold2 fold3

fold%:
	travis_fold open $@
	echo "stuff goes here for $@"
	echo "more stuff"
	echo "yet more"
	travis_fold close $@
