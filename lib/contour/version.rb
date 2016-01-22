# frozen_string_literal: true

module Contour
  module VERSION #:nodoc:
    MAJOR = 3
    MINOR = 1
    TINY = 0
    BUILD = 'pre'.freeze # 'pre', 'rc', 'rc2', nil

    STRING = [MAJOR, MINOR, TINY, BUILD].compact.join('.').freeze
  end
end
