mkdir tmp
for i in $*
do
	cp $i ./tmp -a
done
cd tmp
../shas.sh .
name=$(echo $@ | sed -e 's/ *//' | sha256sum | cut -c1-15).zip
if [[ -f $(which zip) ]]
then
	zip ./$name -r ./
fi
sha256sum $name >> sha256sums.txt
trap "cd ..; rm -rf ./tmp" SIGINT
python3 -m http.server 7042
