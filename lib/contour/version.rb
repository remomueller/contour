module Contour
  module VERSION #:nodoc:
    MAJOR = 1
    MINOR = 2
    TINY = 0
    BUILD = "pre7" # nil, "pre", "rc", "rc2"

    STRING = [MAJOR, MINOR, TINY, BUILD].compact.join('.')
  end
end
