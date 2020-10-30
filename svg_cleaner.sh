# example:
# ONLY use dashes in file name and letters/numbers.
# cd $my_home/Downloads/
# bash $my_home/scripts/svg_to_vue.sh download-icon.svg 32
svg_name=$(echo $1 | sed 's#\.svg##g')
width=$(echo $2 | sed 's/px//g')
px=$(echo "px")
svgCamelCase=$(echo $svg_name | sed -E 's/-(.)/\U\1/g' | sed -e 's/^\(.\)/\U\1/g')
#first line replaces all new linese \n
sed ':a;N;$!ba;s/\n/THE___NEWLINE/g' $1 \
	| sed 's#cls-#svg-cls-#g' \
	| sed 's#<svg #<svg class="svg-'$svg_name'" #g' \
	| sed 's#\ id="[^"]*"##g' \
	| sed 's#THE___NEWLINE#\n#g' > svg_temp.txt

echo "=== SVG Styles ==="
echo -e '\t'".svg-$svg_name-wrap {"
echo -e '\t\t'"width: $width$px;"
echo -e '\t\t'"display: inline-block;"
sed -n '/<style>/,/<\/style>/p' svg_temp.txt \
	| sed 's#<style>#.svg-'$svg_name' {#g' \
	| sed 's#</style>#}#g' \
	| sed 's#  #\t#g'
echo -e '\t'"}"

echo ""

###echo "=== index.js Vue ==="

###echo "import SVG$svgCamelCase from './components/svg/SVG$svgCamelCase.vue';"
###echo "Vue.component('svg-$svg_name', SVG$svgCamelCase);"

sed ':a;N;$!ba;s/\n/THE___NEWLINE/g' svg_temp.txt \
	| sed 's#<style>.*</style>##g' \
	| sed 's#THE___NEWLINE#\n#g' > "$svg_name.svg-new"

echo ""
echo "=== File Created ==="
echo "$svg_name.svg-new"

rm svg_temp.txt

echo ""
echo "=== php/html ==="
echo "<span class=\"svg-$svg_name-wrap m-rotate-180\"><?= curl_get_contents( get_stylesheet_directory_uri(). '/img/svg/$svg_name.svg') ?></span>"

echo ""
echo "=== Problems? ==="
echo "Make sure to set Adobe XD to SVG, Internal CSS, and Embed when exporting the svg."
echo "You may also want to delete the width and height attributes from the svg."
