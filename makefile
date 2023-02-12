.PHONY: push

push:
	echo "git commit"
	git status;
	git add --all;
	git commit -m "update"
	git push
