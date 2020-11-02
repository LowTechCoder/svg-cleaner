# svg-cleaner

LowTech SVG Cleaner

This script is for making an SVG more easily editable through css.  It also works good for keeping SVG, wrapping element, and css more consistent. 

First export an SVG file from Adobe XD, and be sure to Select these options:

xd > export 
format: svg
styling: internal css 

rename the file and only use letters, numbers and dashes, example:
svg-down-chevron.svg

change directory to where the svg file is
cd ~/wherever-your-svg-is/
run the script on the svg, and include a width (using 33 as an example)
bash ~/wherever-your-script-is/svg_cleaner.sh svg-down-chevron.svg 33

The script will output a few things:
* styles
* file name of the new file, appended by '-new', which you will need to remove after copying your file into your project
* php/html
* and a few tips at the bottom if anything goes wrong

Copy the styles and php/html, directly from the terminal.
Copy the new svg file that the script created into your project and remove the '-new' from the file.

This script depends on the curl_get_contents function inside the for_function.php file.  Copy this function to your functions.php file in your wordpress theme.

Once you get all that done, you may want to remove the width and height from the svg file, and change the width in the css if you need.
Now you can change hover state colors or what ever you need by editing the css.
