import
  sdl2


var
  now: uint64  = getPerformanceCounter()
  last: uint64 = 0


proc getDelta*(): float =
  last = now
  now = getPerformanceCounter()

  cast[float](
    cast[float](now - last) / cast[float](getPerformanceFrequency())
  )
