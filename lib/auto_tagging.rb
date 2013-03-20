require "auto_tagging/version"
require "auto_tagging/config"
require "auto_tagging/error"

module AutoTagging
  extend AutoTagging::Config

  def self.get_tags(content = '')
    [] if content.to_s.empty?
    raise AutoTagging::Errors::NoServiceConfigurationError if self.mains.to_a.empty?
    self.mains.map { | main | main.get_tags(content) }.flatten.compact.uniq
  end
end
