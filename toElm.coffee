getPixels = require "get-pixels"
_ = require "lodash"
fs = require "fs
"

padLeft = (number) ->
    if number.length is 3
        number
    else
        padLeft ("0" + number)

groupBy = (input, groupSize) ->
    output = []

    i = 0
    while i < input.length
        output[output.length] = input.slice i, i + groupSize
        i += groupSize

    output


hit = '192,192,192,255'
miss = '0,0,0,255'


alphabet = "abcdefghijklmnopqrstuvwxyz"
numbers = "0123456789"

concat = (list) ->
    [].concat.apply [], list

lettersNames = concat [
    (_.map (alphabet.split ""), (letter) -> letter + "Upper")
    (_.map (alphabet.split ""), (letter) -> letter + "Lower")
    [ "space" ]
    (_.map (numbers.split ""), (number) -> "number" + number)
    [ "period"
    , "comma"
    , "doubleQuote"
    , "singleQuote"
    , "questionMark"
    , "exclaimationMark"
    , "at"
    , "underscore"
    , "asterisk"
    , "hash"
    , "dollar"
    , "percent"
    , "ampersand"
    , "openParenthesis"
    , "closeParenthesis"
    , "plus"
    , "minus"
    , "forwardSlash"
    , "colon"
    , "semiColon"
    , "leftArrow"
    , "equals"
    , "rightArrow"
    , "openBracket"
    , "backSlash"
    , "closeBracket"
    , "caret"
    , "graveQuote"
    , "openCurlyBrace"
    , "line"
    , "closeCurlyBrace"
    , "negation"
    ]
]

jsUcfirst = (letter) ->
    (letter.charAt 0).toUpperCase() + (letter.slice 1)

listToString = (list) ->
    (concat [
        [ "[" ]
        String(list)
        [ "]" ]
    ]).join ""

letters = _.range 1, 94


letters = []
index = 0;

letterToElmFunction = (letter) ->
    (concat [
        [ letter.name, ":", "List (List Bool)" ].join " "
        [ letter.name, "=" ].join " "
        [ "    " + letter.data ]
    ]).join "\n"

finish = ->
    elmFile = concat [
        [ "module Hfnss exposing (..)" ]
        _.map letters, letterToElmFunction
    ]


    fs.writeFileSync "Hfnss.elm", (elmFile.join "\n")


getLetter = (index) ->
    getPixels ("./letters/hfnssC0_" + (padLeft index) + ".png"), (err, image) ->
        pixels = _.map (groupBy image.data, 4), (pixel) ->
            jsUcfirst (String ((String pixel) is hit))

        rows = _.map (groupBy pixels, 11), (row) ->
            (listToString row) + "\n"

        letter =
            name: lettersNames[ index ]
            data: listToString rows

        letters.push letter

        if index > 93
            finish()
        else
            getLetter (index + 1)

getLetter 0

