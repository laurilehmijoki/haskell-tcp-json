{-# LANGUAGE OverloadedStrings #-}

module Json where

import Data.Aeson ((.:), (.:?), decode, FromJSON(..), Value(..))
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
