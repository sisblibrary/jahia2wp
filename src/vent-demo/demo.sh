#!/bin/bash

export ROOT_SITE=www.epfl.ch
CSV_FILE=/srv/$WP_ENV/jahia2wp/src/vent-demo/data/ventilation-demo.csv

export ROOT_WP_DEST=/srv/$WP_ENV/$ROOT_SITE

# This DEMO uses the ventilation-demo.csv rules and the destination site www.epfl.ch. 

# 1) It tries to generate sites at the destination.
# 2) It looks if the source site exists under $WP_ENV, if not it tries to export it.
./vent-demo/utils/setup-demo.sh

# 3) It deletes all the content from the destionation sites (pages, medias, sidebars, menu)
# Delete all content (pages, media, menu, sidebars) from target WP destination tree.
./vent-demo/utils/del-posts.sh

# 4) RUN the migration. Force utf8 for io since c2c container uses a variant of ascii for io.
PYTHONIOENCODING="utf-8" python jahia2wp.py migrate-urls $CSV_FILE $WP_ENV --root_wp_dest=$ROOT_WP_DEST --strict