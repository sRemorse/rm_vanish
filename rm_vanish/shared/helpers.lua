-- Setup debug printing
function PrintDebug(message)
    if config.debug then
        print("^5[DEBUG]: ^r" .. message)
    end