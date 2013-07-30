module Contour
  module VERSION #:nodoc:
    MAJOR = 2
    MINOR = 1
    TINY = 0
    BUILD = "beta1" # nil, "pre", "rc", "rc2"

    STRING = [MAJOR, MINOR, TINY, BUILD].compact.join('.')
  end
end
