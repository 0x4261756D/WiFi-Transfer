mkdir -p tmp
echo "Starting to copy"
for i in $*
do
	if [[ "$i" -ef "./" ]]
	then
		echo "Skipping $i"
	else
		cp $i ./tmp -a
	fi
done
echo "Done copying"
cd tmp
../shas.sh .
if [[ $(which zip) ]]
then
	name=$(echo $@ | sed -e 's/ *//' | sha256sum | cut -c1-15).zip
	zip ./$name -r ./
	sha256sum $name >> sha256sums.txt
fi
trap "cd ..; rm -rf ./tmp" SIGINT
python3 -m http.server 7042
