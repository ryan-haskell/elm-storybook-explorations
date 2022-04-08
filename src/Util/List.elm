module Util.List exposing (mapWithPositionInfo)


mapWithPositionInfo :
    ({ isFirst : Bool, isLast : Bool } -> a -> b)
    -> List a
    -> List b
mapWithPositionInfo fn list =
    List.indexedMap
        (\index item ->
            fn
                { isFirst = index == 0
                , isLast = index == List.length list - 1
                }
                item
        )
        list
