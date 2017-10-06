# Hfnss

Hfnss is my standard font that I made and use everywhere. Its a pixel font, so its not meant to be used with any antialiasing I also have the font as 94  11x19 png files for every character. I needed to use my font on an HTML canvas, but my trouble was that it was getting antialiased. My work around is to draw each pixel of each character manually. To do that, I needed lists of each pixel. Thats where this repo comes in. This repo reads all the letters in `./letters`, and turns them into `List (List Pixel)` where each `List Pixel` is a row of pixels, and each `Pixel` is gray or black.


## Quick start
```
npm install
coffee toElm.coffee
elm-format ./Hfnss.elm --yes
```

And `Hfnss.elm` is now an Elm module with every letter as an Elm function.
