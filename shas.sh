echo "" > sha256sums.txt
for i in $*
do
 if [[ -f $i ]]
 then
  sha256sum $i | tee -a sha256sums.txt
 elif [[ -d $i ]]
 then
  fls=$(find $i -type f)
  for j in $fls
  do
   sha256sum $j | tee -a sha256sums.txt
  done
 fi
done
