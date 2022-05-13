# What's this?

_it's an art project_

no really it's a tool that generates error pages to be served statically using:

- shell scripting
- gnu sed
- tailwindcss (because i don't know css and should be shamed for it)

it uses the 3 languages i speak for errors just for the sake of it. you may change the text so that i matches languages you care about.

# get going

1. set the variables in `gen.sh` so they match the name of your pretend organisation (the way i do with potate.space)
2. check that `errors.tsv` contains the kind of errors you want to display, among with what strings you want to use
3. run `yarn && yarn gen:css && yarn gen:html` or `docker build .` if you have docker
4. profit, the files to serve are in `dist` in you working directory or in `/var/www/htdocs/` in the resulting container; the container can be started as is, and will serve your error pages with [darkhttpd](https://github.com/emikulic/darkhttpd) (that i love dearly and use everywhere)

# can i use this?

if i sent it to you, you may

don't know if i will figure out licensing for this project as it has no inherant value

~ Élise