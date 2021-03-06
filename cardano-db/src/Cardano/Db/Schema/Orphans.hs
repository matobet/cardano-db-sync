{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-orphans #-}

module Cardano.Db.Schema.Orphans where

import           Cardano.Db.Types (DbInt65 (..), DbLovelace (..), DbWord64 (..), readDbInt65,
                   showDbInt65)

import           Data.Ratio (denominator, numerator)
import           Data.WideWord.Word128 (Word128)

import qualified Data.Text as Text

import           Database.Persist.Class (PersistField (..))
import           Database.Persist.Types (PersistValue (..))

instance PersistField DbInt65 where
  toPersistValue = PersistText . Text.pack . showDbInt65
  fromPersistValue (PersistInt64 i) = Right $ if i >= 0
                                                then PosInt65 (fromIntegral i)
                                                else NegInt65 (fromIntegral $ negate i)
  fromPersistValue (PersistText bs) = Right $ readDbInt65 (Text.unpack bs)
  fromPersistValue x@(PersistRational r) =
    if denominator r == 1
      then Right $ if numerator r >= 0
                    then PosInt65 (fromIntegral $ numerator r)
                    else NegInt65 (fromIntegral . numerator $ negate r)
      else Left $ mconcat [ "Failed to parse Haskell type DbInt65: ", Text.pack (show x) ]
  fromPersistValue x =
    Left $ mconcat [ "Failed to parse Haskell type DbInt65: ", Text.pack (show x) ]

instance PersistField DbLovelace where
  toPersistValue = PersistText . Text.pack . show . unDbLovelace
  fromPersistValue (PersistInt64 i) = Right $ DbLovelace (fromIntegral i)
  fromPersistValue (PersistText bs) = Right $ DbLovelace (read $ Text.unpack bs)
  fromPersistValue x@(PersistRational r) =
    -- If the value is greater than MAX_INT64, it comes back as a PersistRational (wat??).
    if denominator r == 1
      then Right $ DbLovelace (fromIntegral $ numerator r)
      else Left $ mconcat [ "Failed to parse Haskell type DbLovelace: ", Text.pack (show x) ]
  fromPersistValue x =
    Left $ mconcat [ "Failed to parse Haskell type DbLovelace: ", Text.pack (show x) ]

instance PersistField DbWord64 where
  toPersistValue = PersistText . Text.pack . show . unDbWord64
  fromPersistValue (PersistInt64 i) = Right $ DbWord64 (fromIntegral i)
  fromPersistValue (PersistText bs) = Right $ DbWord64 (read $ Text.unpack bs)
  fromPersistValue x@(PersistRational r) =
    -- If the value is greater than MAX_INT64, it comes back as a PersistRational (wat??).
    if denominator r == 1
      then Right $ DbWord64 (fromIntegral $ numerator r)
      else Left $ mconcat [ "Failed to parse Haskell type DbWord64: ", Text.pack (show x) ]
  fromPersistValue x =
    Left $ mconcat [ "Failed to parse Haskell type DbWord64: ", Text.pack (show x) ]

instance PersistField Word128 where
  toPersistValue = PersistText . Text.pack . show
  fromPersistValue (PersistText bs) = Right $ read (Text.unpack bs)
  fromPersistValue x@(PersistRational r) =
    if denominator r == 1
      then Right $ fromIntegral (numerator r)
      else Left $ mconcat [ "Failed to parse Haskell type Word128: ", Text.pack (show x) ]
  fromPersistValue x =
    Left $ mconcat [ "Failed to parse Haskell type Word128: ", Text.pack (show x) ]
