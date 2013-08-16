ThinkingSphinx::Index.define :issue, :with => :active_record, :delta => true do
  indexes subject
  indexes body
end