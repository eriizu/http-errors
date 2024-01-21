#/bin/bash

set -e

TSV_FILE=$1
TGT_DIR=$2
if [ -z "$TSV_FILE" ]; then
	>&2 echo "provide a tab separeted values file to generate pages with"
	exit 1
fi

if [ -z "$TGT_DIR" ]; then
	>&2 echo "provide a target directory to generate the pages in"
	exit 1
fi

TEMPLATE_AUTHOR="Élise"
TEMPLATE_VENDOR_SHORT="PSS"
TEMPLATE_VENDOR_LONG="Potate Systems and Services"
TEMPLATE_CONTACT="none@example.com (do not contact us)"
# STYLES="https://err.example.com/styles.css"

tailwindcss -i ./src/styles.css  -o ./dist/styles.css --minify

while read y; do
	# echo "Line contents are : $y"
	FILE_NAME=$(echo -n "$y" | cut --field=1)
	TEMPLATE_CODE=$(echo -n "$y" | cut --field=2)
	TEMPLATE_MSG_EN=$(echo -n "$y" | cut --field=3)
	TEMPLATE_MSG_FR=$(echo -n "$y" | cut --field=4)
	TEMPLATE_MSG_JP=$(echo -n "$y" | cut --field=5)
	TEMPLATE_DESC=$(echo -n "$y" | cut --field=6)

	cp -v src/template.html "$TGT_DIR/$FILE_NAME"
	sed -i "s/<\!-- TEMPLATE_STYLE -->/<style>\nTEMPLATE_CSS\n<\/style>/g" "$TGT_DIR/$FILE_NAME"
	sed -i "/TEMPLATE_CSS/r ${TGT_DIR}/styles.css" "$TGT_DIR/$FILE_NAME"
	#sed -i "s/TEMPLATE_CSS//g" "$TGT_DIR/$FILE_NAME"
	# sed -i "/<\!-- TEMPLATE_CSS -->/r ${TGT_DIR}/styles.css" "$TGT_DIR/$FILE_NAME"
	# sed -i "s/TEMPLATE_CSS/d" "$TGT_DIR/$FILE_NAME"
	sed -i "s/FILE_NAME/${FILE_NAME}/g" "$TGT_DIR/$FILE_NAME"
	sed -i "s/TEMPLATE_CODE/${TEMPLATE_CODE}/g" "$TGT_DIR/$FILE_NAME"
	sed -i "s/TEMPLATE_MSG_EN/${TEMPLATE_MSG_EN}/g" "$TGT_DIR/$FILE_NAME"
	sed -i "s/TEMPLATE_MSG_FR/${TEMPLATE_MSG_FR}/g" "$TGT_DIR/$FILE_NAME"
	sed -i "s/TEMPLATE_MSG_JP/${TEMPLATE_MSG_JP}/g" "$TGT_DIR/$FILE_NAME"
	sed -i "s/TEMPLATE_DESC/${TEMPLATE_DESC}/g" "$TGT_DIR/$FILE_NAME"
	sed -i "s/TEMPLATE_AUTHOR/${TEMPLATE_AUTHOR}/g" "$TGT_DIR/$FILE_NAME"
	sed -i "s/TEMPLATE_VENDOR_LONG/${TEMPLATE_VENDOR_LONG}/g" "$TGT_DIR/$FILE_NAME"
	sed -i "s/TEMPLATE_VENDOR_SHORT/${TEMPLATE_VENDOR_SHORT}/g" "$TGT_DIR/$FILE_NAME"
	# sed -i "s|TEMPLATE_STYLE|${STYLES}|g" "$TGT_DIR/$FILE_NAME"
	sed -i "s|TEMPLATE_CONTACT|${TEMPLATE_CONTACT}|g" "$TGT_DIR/$FILE_NAME"
	echo $FILE_NAME
done <$TSV_FILE
