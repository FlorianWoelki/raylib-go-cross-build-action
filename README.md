# raylib-go-cross-build-action

This simple repository allows automatic artifact creation of your [raylib-go](https://github.com/gen2brain/raylib-go) game.

This current action lets you generate the following binaries for the following architectures:
* windows/amd64
* windows/i386

## How to use

A simple GitHub Action workflow example can look like this:
```yml
# workflow name
name: Generate windows artifacts

# on events
on:
  release:
    types:
      - created

# workflow tasks
jobs:
  generate:
    name: Generate windows binaries
    runs-on: ubuntu-latest
    steps:
      - name: Checkout the repository
        uses: actions/checkout@v2
      - name: Make binaries
        uses: florianwoelki/raylib-go-cross-build-action@main
```
