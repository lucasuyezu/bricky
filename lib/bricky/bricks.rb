require "bricky/bricks/base"

require "bricky/bricks/helper"
require "bricky/bricks/ruby"
require "bricky/bricks/bundle"
require "bricky/bricks/debian"
require "bricky/bricks/mounts"

module Bricky
  module Bricks
    extend self

    def resolve
      default_bricks + Bricky.config.bricks.collect do |name, config|
       resolve_and_initialize(name, config)
      end.uniq
    end

    def resolve_and_initialize(name, config)
      return Bricky::Bricks::Bundle.new(config) if name.eql? "bundle"
      return Bricky::Bricks::Debian.new(config) if name.eql? "debian"
      return Bricky::Bricks::Mounts.new(config) if name.eql? "mounts"
    end

    private
      def default_bricks
        [Bricky::Bricks::Helper.new({})]
      end
  end
end
