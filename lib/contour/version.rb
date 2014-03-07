module Contour
  module VERSION #:nodoc:
    MAJOR = 2
    MINOR = 4
    TINY = 0
    BUILD = "rc2" # nil, "pre", "rc", "rc2"

    STRING = [MAJOR, MINOR, TINY, BUILD].compact.join('.')
  end
end
