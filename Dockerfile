FROM node AS build

WORKDIR /wd

COPY errors.tsv package.json yarn.lock tailwind.config.js gen.sh /wd/

RUN yarn

COPY src/template.html src/styles.css /wd/src/

RUN mkdir dist/ && yarn gen:css && yarn gen:html

FROM eriizu/darkhttpd

COPY --from=build /wd/dist/* /var/www/htdocs/
COPY --from=build /wd/dist/styles.css /var/www/htdocs/
