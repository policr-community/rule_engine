require "./rule_engine/*"

module RuleEngine
  def self.parse!(rule_s : String)
    Parser.parse!(rule_s)
  end
end
