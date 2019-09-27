module RuleEngine
  class Unit
    alias KeywordList = Array(String)

    getter keywords : KeywordList

    def initialize(unit_s : String)
      list = unit_s.split "|"
      if list.size > 0
        @keywords = list
      else
        @keywords = [unit_s]
      end
    end

    def self_contained?(content : String)
      @keywords.each do |keyword|
        return true if content.includes? keyword
      end
      false
    end
  end

  class Group
    alias UnitList = Array(Unit)

    getter units = UnitList.new

    def initialize
    end

    def add_unit(unit : Unit)
      units << unit
    end

    def self_contained?(content : String)
      @units.each do |unit|
        return false unless unit.self_contained? content
      end
      true
    end
  end

  class Rule
    alias GroupList = Array(Group)

    getter groups = GroupList.new

    def initialize
    end

    def add_group(group : Group)
      groups << group
    end

    def match?(content : String)
      content = content.gsub(" ", "").downcase

      @groups.each do |group|
        return true if group.self_contained? content
      end
      false
    end
  end
end
