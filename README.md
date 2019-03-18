# Convert html-to-pdf via dockerized chrome headless

Because currently the `--print-to-pdf` CLI switch does not allow disabling of
header/footer the approach uses a nodejs script which connects to chrome via
remote interface. It also executes 5s of javascript (virtual time) to ensure
that the page is fully rendered.

Check out the code by my colleague: [chrome-headless-render](https://github.com/Szpadel/chrome-headless-render-pdf).

## How to run it?

You need to mount a container workdir locally to be able to get the output file.
Also because chrome uses some kernel feature for sandboxing you need to run the container
in `--privileged` mode. It's possible to work around this by disabling sandboxing
but this seems to work best.

The workdir is `/tmp/html-to-pdf`, thus running:

```
docker run -v `pwd`:/tmp/html-to-pdf --privileged robotvert/docker-html-to-pdf --url http://google.com --pdf out.pdf
```

Will produce `out.pdf` file in the current directory.

## Version tags

The container versioning scheme is `${MAJOR_CHROME_VERSION}.${CONTAINER_VERSION}`
