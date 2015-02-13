module Contour
  module VERSION #:nodoc:
    MAJOR = 3
    MINOR = 0
    TINY = 0
    BUILD = "pre" # nil, "pre", "rc", "rc2"

    STRING = [MAJOR, MINOR, TINY, BUILD].compact.join('.')
  end
end
