module Contour
  module VERSION #:nodoc:
    MAJOR = 2
    MINOR = 2
    TINY = 1
    BUILD = "rc" # nil, "pre", "rc", "rc2"

    STRING = [MAJOR, MINOR, TINY, BUILD].compact.join('.')
  end
end
