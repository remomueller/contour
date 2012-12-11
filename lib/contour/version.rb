module Contour
  module VERSION #:nodoc:
    MAJOR = 1
    MINOR = 1
    TINY = 2
    BUILD = "pre2" # nil, "pre", "rc", "rc2"

    STRING = [MAJOR, MINOR, TINY, BUILD].compact.join('.')
  end
end
