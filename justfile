dev:
	tailwindcss -i ./src/styles.css -o ./src/dev_styles.css --watch

gen:
	sh ./gen.sh errors.tsv dist

