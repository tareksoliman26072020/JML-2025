module Color where

import Text.Printf (printf)

yellow :: String -> String
yellow = printf "\ESC[1;33m%s\ESC[m"
