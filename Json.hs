{-# LANGUAGE OverloadedStrings #-}

module Json where

import Data.Aeson ((.:), (.:?), decode, encode, (.=), object, FromJSON(..), ToJSON(..), Value(..))
import Control.Applicative ((<$>), (<*>))
import Data.Time.Format     (parseTime)
import Data.Time.Clock      (UTCTime)
import System.Locale        (defaultTimeLocale)
import Control.Monad        (liftM)

data Paste = Paste { getLines    :: Integer
                   , getDate     :: Maybe UTCTime
                   , getID       :: String
                   , getLanguage :: String
                   , getPrivate  :: Bool
                   , getURL      :: String
                   , getUser     :: Maybe String
                   , getBody     :: String
                   } deriving (Show)

data Response = Response { getGreeting :: String } deriving (Show)

instance ToJSON Response where
  toJSON Response{..} = object [ "greeting" .= getGreeting ]

instance FromJSON Paste where
  parseJSON (Object v) =
    Paste <$>
    (v .: "lines")                  <*>
    liftM parseRHTime (v .: "date") <*>
    (v .: "paste-id")               <*>
    (v .: "language")               <*>
    (v .: "private")                <*>
    (v .: "url")                    <*>
    (v .:? "user")                  <*>
    (v .: "contents")

parseRHTime :: String -> Maybe UTCTime
parseRHTime = parseTime defaultTimeLocale "%FT%X%QZ"

parsePaste json = (decode json :: Maybe Paste)

asJson greeting = encode greeting
