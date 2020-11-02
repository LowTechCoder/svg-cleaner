# example:
# bash /home/matt/scripts/svg_cleaner.sh svg-down-chevron.svg 33^C
svg_name=$(echo $1 | sed 's#\.svg##g') # remove .svg file ext 
width=$(echo $2 | sed 's/px//g') # rm 'px' from width if 'px' was used
px=$(echo "px")

#first line replaces all new linese \n
sed ':a;N;$!ba;s/\n/THE___NEWLINE/g' $1 | # replace new lines with THE___NEWLINE to help sed work easier.  Sometimes the output of this can look like it's leaving out parts of the file, but it's actually fine.
	sed 's#cls-#svg-cls-#g' | # replace 'cls-' with 'svg-cls-'
	sed 's#<svg #<svg class="svg-'$svg_name'" #g' | # add this class to the svg element: svg-'$svg_name'
	sed 's#\ id="[^"]*"##g' | # remove all id's
	sed 's#THE___NEWLINE#\n#g' > svg_temp.txt # replace THE___NEWLINE with new lines

echo "=== SVG Styles ==="
echo -e '\t'".svg-$svg_name-wrap {"
echo -e '\t\t'"width: $width$px;"
echo -e '\t\t'"display: inline-block;"
sed -n '/<style>/,/<\/style>/p' svg_temp.txt |
	sed 's#<style>#.svg-'$svg_name' {#g' |
	sed 's#</style>#}#g' |
	sed 's#  #\t#g'
echo -e '\t'"}"

echo ""

sed ':a;N;$!ba;s/\n/THE___NEWLINE/g' svg_temp.txt | # replace new lines with THE___NEWLINE to help sed work easier.  Sometimes the output of this can look like it's leaving out parts of the file, but it's actually fine.
	sed 's#<style>.*</style>##g' | # remove styles
	sed 's#THE___NEWLINE#\n#g' > "$svg_name.svg-new" # replace THE___NEWLINE with new lines

echo ""
echo "=== File Created ==="
echo "$svg_name.svg-new"

rm svg_temp.txt

echo ""
echo "=== php/html ==="
echo "<span class=\"svg-$svg_name-wrap m-rotate-180\"><?= curl_get_contents( get_stylesheet_directory_uri(). '/img/svg/$svg_name.svg') ?></span>"

echo ""
echo "=== Problems? ==="
echo "ONLY use dashes in file name and letters/numbers."
echo "Make sure to set Adobe XD to SVG, Internal CSS, and Embed when exporting the svg."
echo "You may also want to delete the width and height attributes from the svg."
