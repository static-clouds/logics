module Logic where

import qualified Data.Map as Map

data BinOp = Conj | Disj | XOr | Impl | BImpl deriving (Eq, Show, Generic)
data UnOp = Neg deriving (Eq, Show, Generic)

data Logic t = Val t | Un UnOp (Logic t) | Bin BinOp (Logic t) (Logic t) deriving (Eq, Show, Generic)


replace :: (Ord t, Show t) => Logic t -> Map.Map t (Logic t') -> Maybe (Logic t')
replace (Val a) assignment = do
  p <- Map.lookup a assignment
  pure p

replace (Un unOp l) assignment = do
  l' <- replace l assignment
  pure $ Un unOp l'

replace (Bin unOp l r) assignment = do
  l' <- replace l assignment
  r' <- replace r assignment
  pure $ Bin unOp l' r'
