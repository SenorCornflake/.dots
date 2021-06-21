# Generate plain color background
bg=$(exconman get polybar.1_bg)
convert -size 1920x1080 xc:"$bg" ~/wallpapers/solid.png

# Generate background with dots
bg=$(exconman get polybar.3_bg)
fg=$(exconman get polybar.3_fg)
convert -size 35x35 xc:"$bg" -fill "$fg" -draw "rectangle 17,17 17,17" ~/MAIN/tmp/tiler.png
convert -size 1920x1080 tile:"$HOME/MAIN/tmp/tiler.png" ~/wallpapers/simple-dots.png
rm ~/MAIN/tmp/tiler.png

# Generate background thicker with dots
bg=$(exconman get polybar.3_bg)
fg=$(exconman get polybar.3_fg)
convert -size 100x100 xc:"$bg" -fill "$fg" -draw "rectangle 49,49 51,51" ~/MAIN/tmp/tiler.png
convert -size 1920x1080 tile:"$HOME/MAIN/tmp/tiler.png" ~/wallpapers/simple-thick-dots.png
rm ~/MAIN/tmp/tiler.png
