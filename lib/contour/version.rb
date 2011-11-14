module Contour
  module VERSION #:nodoc:
    MAJOR = 0
    MINOR = 6
    TINY = 1
    BUILD = "pre" # nil, "pre", "rc", "rc2"

    STRING = [MAJOR, MINOR, TINY, BUILD].compact.join('.')
  end
end