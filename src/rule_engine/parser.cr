module RuleEngine
  class Parser
    RE_RULE = /\[([^\[\]]+)\]/

    def self.parse!(rule_s : String) : Rule
      rule = Rule.new
      if list = rule_s.scan RE_RULE
        list.each do |md|
          group = Group.new
          md[1].split(" ", remove_empty: true).each do |unit_s|
            group.add_unit Unit.new unit_s
          end

          rule.add_group group
        end
      end
      rule
    end
  end
end
