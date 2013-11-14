# TCP + JSON in Haskell

## Install

First, install <http://www.haskell.org/ghc/download>

    cabal install aeson

## Usage

    runhaskell -XRecordWildCards Main.hs 9999
    nc localhost 9999
    {"lines":1,"date":"2012-01-04T01:44:22.964Z","paste-id":"1","fork":null,"random-id":"f1fc1181fb294950ca4df7008","language":"Clojure","private":false,"url":"https://www.refheap.com/paste/1","user":"raynes","contents":"(begin)"}
