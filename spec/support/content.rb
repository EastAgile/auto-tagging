FIXTURE_CONTENTS = YAML::load( File.open(File.join(File.dirname(__FILE__), '../fixtures/content.yml')) )
shared_context 'load fixture contents' do
  FIXTURE_CONTENTS.each { |key, value| let(key) { value } }
end

module FixtureContent
  def self.included(scope)
    scope.include_context "load fixture contents"
  end
end
