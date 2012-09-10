module Contour
  module VERSION #:nodoc:
    MAJOR = 1
    MINOR = 1
    TINY = 0
    BUILD = "rc3" # nil, "pre", "rc", "rc2"

    STRING = [MAJOR, MINOR, TINY, BUILD].compact.join('.')
  end
end
