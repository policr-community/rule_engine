require "./spec_helper"

alias Rule = RuleEngine::Rule
alias Group = RuleEngine::Group
alias Unit = RuleEngine::Unit
alias Parser = RuleEngine::Parser

describe RuleEngine do
  it "parse!" do
    RuleEngine.parse!("[嘻嘻 哈哈]").should be_truthy
  end

  describe RuleEngine::Rule do
    it "self_contained?" do
      u1_s = "东南亚|柬埔寨"
      u2_s = "菠菜|博彩"
      u3_s = "招聘|QQ|微信|wx|WX"

      g1 = Group.new
      g1.add_unit Unit.new(u1_s)
      g1.add_unit Unit.new(u2_s)
      g1.add_unit Unit.new(u3_s)

      r1 = Rule.new
      r1.add_group g1

      r1.match?("柬埔寨招菠菜 WX: 12345").should eq(true)
      r1.match?("柬埔寨招菠菜").should eq(false)

      content =
        <<-TEXT
        A here document or heredoc can be useful for writing strings spanning over multiple lines. A heredoc is denoted by <<- followed by an heredoc identifier which is an alphanumeric sequence starting with a letter (and may include underscores). The heredoc starts in the following line and ends with the next line that starts with the heredoc identifier (ignoring leading whitespace) and is either followed by a newline or a non-alphanumeric character.
        柬埔寨 招 菠菜 WX
        TEXT
      Benchmark.ips do |x|
        x.report("expand(long)") { r1.match? content }
        x.report("expand(short)") { r1.match? "我们柬埔寨正在招聘菠菜 WX" }
        x.report("regex#=~") { /(柬埔寨|东南亚).*(招聘|QQ|微信|wx|WX).*(博彩|菠菜)/ =~ content }
      end
    end
  end

  describe RuleEngine::Parser do
    it "parse!" do
      rule_s = "[东南亚|柬埔寨 菠菜|博彩 招聘|QQ|微信|wx|WX]"
      r1 = Parser.parse! rule_s
      r1.match?("柬埔寨 菠菜 招聘").should eq(true)
      r1.match?("柬埔寨 菠菜").should eq(false)

      content =
        <<-TEXT
        A here document or heredoc can be useful for writing strings spanning over multiple lines. A heredoc is denoted by <<- followed by an heredoc identifier which is an alphanumeric sequence starting with a letter (and may include underscores). The heredoc starts in the following line and ends with the next line that starts with the heredoc identifier (ignoring leading whitespace) and is either followed by a newline or a non-alphanumeric character.
        柬埔寨 招 菠菜 WX
        TEXT
      Benchmark.ips do |x|
        x.report("parsing(long)") { Parser.parse!(rule_s).match? content }
        x.report("parsing(short)") { Parser.parse!(rule_s).match? "我们柬埔寨正在招聘菠菜 WX" }
      end
    end
  end
end
