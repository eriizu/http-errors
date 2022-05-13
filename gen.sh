#/bin/bash

set -e

TSV_FILE=$1
DIR=$2
TEMPLATE_AUTHOR="Élise"
TEMPLATE_VENDOR_SHORT="PSS"
TEMPLATE_VENDOR_LONG="Potate Systems and Services"
TEMPLATE_CONTACT="none@example.com (do not contact us)"
# STYLES="https://err.example.com/styles.css"

while read y; do
	# echo "Line contents are : $y"
	FILE_NAME=$(echo -n "$y" | cut --field=1)
	TEMPLATE_CODE=$(echo -n "$y" | cut --field=2)
	TEMPLATE_MSG_EN=$(echo -n "$y" | cut --field=3)
	TEMPLATE_MSG_FR=$(echo -n "$y" | cut --field=4)
	TEMPLATE_MSG_JP=$(echo -n "$y" | cut --field=5)
	TEMPLATE_DESC=$(echo -n "$y" | cut --field=6)

	cp -v src/template.html "$DIR/$FILE_NAME"
	sed -i "s/TEMPLATE_STYLE/<style>\nTEMPLATE_CSS\n<\/style>/g" "$DIR/$FILE_NAME"
	sed -i "/TEMPLATE_CSS/r ${DIR}/styles.css" "$DIR/$FILE_NAME"
	sed -i "s/TEMPLATE_CSS//g" "$DIR/$FILE_NAME"
	sed -i "s/FILE_NAME/${FILE_NAME}/g" "$DIR/$FILE_NAME"
	sed -i "s/TEMPLATE_CODE/${TEMPLATE_CODE}/g" "$DIR/$FILE_NAME"
	sed -i "s/TEMPLATE_MSG_EN/${TEMPLATE_MSG_EN}/g" "$DIR/$FILE_NAME"
	sed -i "s/TEMPLATE_MSG_FR/${TEMPLATE_MSG_FR}/g" "$DIR/$FILE_NAME"
	sed -i "s/TEMPLATE_MSG_JP/${TEMPLATE_MSG_JP}/g" "$DIR/$FILE_NAME"
	sed -i "s/TEMPLATE_DESC/${TEMPLATE_DESC}/g" "$DIR/$FILE_NAME"
	sed -i "s/TEMPLATE_AUTHOR/${TEMPLATE_AUTHOR}/g" "$DIR/$FILE_NAME"
	sed -i "s/TEMPLATE_VENDOR_LONG/${TEMPLATE_VENDOR_LONG}/g" "$DIR/$FILE_NAME"
	sed -i "s/TEMPLATE_VENDOR_SHORT/${TEMPLATE_VENDOR_SHORT}/g" "$DIR/$FILE_NAME"
	# sed -i "s|TEMPLATE_STYLE|${STYLES}|g" "$DIR/$FILE_NAME"
	sed -i "s|TEMPLATE_CONTACT|${TEMPLATE_CONTACT}|g" "$DIR/$FILE_NAME"
	echo $FILE_NAME
done <$TSV_FILE
